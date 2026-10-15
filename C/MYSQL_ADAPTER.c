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
    if (tls_enabled) {
        mysql_ssl_set(g_mysql, NULL, NULL, NULL, NULL, NULL);
    }
    return mysql_real_connect(g_mysql, host, user, password, database,
                              port, NULL, 0) != NULL ? 0 : 1;
}

int mysql_native_c_status(void) {
    return g_mysql != NULL ? 1 : 0;
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

const char *mysql_native_c_error(void) {
    return g_mysql ? mysql_error(g_mysql) : "MySQL client is not initialized";
}

void mysql_native_c_close(void) {
    if (g_mysql) {
        mysql_close(g_mysql);
        g_mysql = NULL;
    }
}
