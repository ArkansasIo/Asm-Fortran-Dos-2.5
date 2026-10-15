#include <mysql/mysql.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>

static MYSQL *g_mysql = NULL;

int mysql_native_c_init(void) {
    if (g_mysql != NULL) return 0;
    g_mysql = mysql_init(NULL);
    return g_mysql != NULL ? 0 : 1;
}

int mysql_native_c_connect(const char *host, const char *user,
                           const char *password, const char *database,
                           unsigned int port, unsigned int timeout,
                           int tls_enabled) {
    if (g_mysql == NULL && mysql_native_c_init() != 0) return 1;
    mysql_options(g_mysql, MYSQL_OPT_CONNECT_TIMEOUT, &timeout);
    if (tls_enabled) mysql_ssl_set(g_mysql, NULL, NULL, NULL, NULL, NULL);
    return mysql_real_connect(g_mysql, host, user, password, database,
                              port, NULL, 0) != NULL ? 0 : 1;
}

int mysql_native_c_status(void) {
    return (g_mysql != NULL && mysql_ping(g_mysql) == 0) ? 1 : 0;
}

int mysql_native_c_execute(const char *sql, unsigned long length,
                           long long *affected_rows, unsigned long long *insert_id) {
    if (g_mysql == NULL || sql == NULL) return 1;
    if (mysql_real_query(g_mysql, sql, length) != 0) return (int)mysql_errno(g_mysql);
    if (affected_rows) *affected_rows = (long long)mysql_affected_rows(g_mysql);
    if (insert_id) *insert_id = mysql_insert_id(g_mysql);
    return 0;
}

int mysql_native_c_begin(void) { return mysql_native_c_execute("START TRANSACTION", 17, NULL, NULL); }
int mysql_native_c_commit(void) { return mysql_native_c_execute("COMMIT", 6, NULL, NULL); }
int mysql_native_c_rollback(void) { return mysql_native_c_execute("ROLLBACK", 8, NULL, NULL); }

/*
 * Generic prepared execution for one or more parameters.
 * param_types uses 's' for string, 'i' for signed 64-bit integer,
 * and 'd' for double. params contains pointers to the corresponding values.
 */
int mysql_native_c_prepare_execute(const char *sql, unsigned long sql_length,
                                   const char *param_types, void **params,
                                   unsigned int param_count,
                                   long long *affected_rows,
                                   unsigned long long *insert_id) {
    MYSQL_STMT *stmt = NULL;
    MYSQL_BIND *bind = NULL;
    unsigned int i;
    int rc = 1;

    if (g_mysql == NULL || sql == NULL) return 1;
    if (param_count > 0 && (param_types == NULL || params == NULL)) return 1;

    stmt = mysql_stmt_init(g_mysql);
    if (stmt == NULL) return (int)mysql_errno(g_mysql);
    if (mysql_stmt_prepare(stmt, sql, sql_length) != 0) goto cleanup;

    if (param_count > 0) {
        bind = (MYSQL_BIND *)calloc(param_count, sizeof(MYSQL_BIND));
        if (bind == NULL) goto cleanup;
        for (i = 0; i < param_count; ++i) {
            switch (param_types[i]) {
                case 's':
                    bind[i].buffer_type = MYSQL_TYPE_STRING;
                    bind[i].buffer = params[i];
                    bind[i].buffer_length = (unsigned long)strlen((const char *)params[i]);
                    bind[i].length = &bind[i].buffer_length;
                    break;
                case 'i':
                    bind[i].buffer_type = MYSQL_TYPE_LONGLONG;
                    bind[i].buffer = params[i];
                    bind[i].is_unsigned = 0;
                    break;
                case 'd':
                    bind[i].buffer_type = MYSQL_TYPE_DOUBLE;
                    bind[i].buffer = params[i];
                    break;
                default:
                    goto cleanup;
            }
        }
        if (mysql_stmt_bind_param(stmt, bind) != 0) goto cleanup;
    }

    if (mysql_stmt_execute(stmt) != 0) goto cleanup;
    if (affected_rows) *affected_rows = (long long)mysql_stmt_affected_rows(stmt);
    if (insert_id) *insert_id = mysql_stmt_insert_id(stmt);
    rc = 0;

cleanup:
    if (bind) free(bind);
    if (stmt) mysql_stmt_close(stmt);
    return rc;
}

const char *mysql_native_c_error(void) {
    return g_mysql ? mysql_error(g_mysql) : "MySQL client is not initialized";
}

const char *mysql_native_c_stmt_error(void) {
    return g_mysql ? mysql_stmt_error(NULL) : "MySQL client is not initialized";
}

void mysql_native_c_close(void) {
    if (g_mysql) {
        mysql_close(g_mysql);
        g_mysql = NULL;
    }
}
