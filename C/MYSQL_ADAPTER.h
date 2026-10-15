#ifndef BUSINESS_OS_MYSQL_ADAPTER_H
#define BUSINESS_OS_MYSQL_ADAPTER_H

#ifdef __cplusplus
extern "C" {
#endif

int mysql_native_c_init(void);
int mysql_native_c_connect(const char *host, const char *user,
                           const char *password, const char *database,
                           unsigned int port, unsigned int timeout,
                           int tls_enabled);
int mysql_native_c_status(void);
int mysql_native_c_execute(const char *sql, unsigned long length,
                           long long *affected_rows,
                           unsigned long long *insert_id);
int mysql_native_c_prepare_execute(const char *sql, unsigned long sql_length,
                                   const char *param_types, void **params,
                                   unsigned int param_count,
                                   long long *affected_rows,
                                   unsigned long long *insert_id);
int mysql_native_c_begin(void);
int mysql_native_c_commit(void);
int mysql_native_c_rollback(void);
const char *mysql_native_c_error(void);
const char *mysql_native_c_stmt_error(void);
void mysql_native_c_close(void);

#ifdef __cplusplus
}
#endif

#endif
