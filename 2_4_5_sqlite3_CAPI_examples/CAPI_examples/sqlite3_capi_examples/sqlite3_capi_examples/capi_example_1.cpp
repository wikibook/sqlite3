#include "stdafx.h"
#include "sqlite3.h"
#include <string.h>
#include <Windows.h> 

#include <ctime>
using namespace std;

/***********************************************************
  testing sqlite3_open, sqlite3_close

  sqlite3_open()을 이용하여 database 파일이 정상적으로 열리는지,
  sqlite3_close()을 이용하여 정상적으로 닫히는지 확인한다.
  test.db 파일이 생성되어 있는 것을 확인할 수 있다.

int sqlite3_open(
  const char *filename,   // Database filename (UTF-8)
  sqlite3 **ppDb          // OUT: SQLite db handle
);

int sqlite3_close(sqlite3 *);

 ***********************************************************/
int capi_example_1()
{
	sqlite3 *db;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	rc = sqlite3_close(db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_close error : %s\n", sqlite3_errmsg(db));
		return -1;
	}	
	return 0;
}

/***********************************************************
  testing sqlite3_open, sqlite3_close

  db파일명에 한글(utf8)이 포함된 경우에, 해당 db 파일이 정상적으로
  생성되는지를 확인한다.
  탐색기를 통해 '테스트_utf8.db' 파일이 생성되었음을 확인할 수 있다.
 ***********************************************************/
int capi_example_2()
{
	sqlite3 *db;
	int rc;

	rc = sqlite3_open("\xed\x85\x8c\xec\x8a\xa4\xed\x8a\xb8_utf8.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	rc = sqlite3_close(db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_close error : %s\n", sqlite3_errmsg(db));
		return -1;
	}	
	return 0;
}

/***********************************************************
  testing sqlite3_open16, sqlite3_close

  db파일명에 한글(utf16, ucs2)이 포함된 경우, 해당 db파일이
  정상적으로 생성되는지를 확인한다.
  탐색기를 통해 '테스트_utf16.db' 파일이 생성되었음을 확인할 수 있다.

int sqlite3_open16(
  const void *filename,   // Database filename (UTF-16)
  sqlite3 **ppDb          // OUT: SQLite db handle
);
 ***********************************************************/
int capi_example_3()
{
	sqlite3 *db;
	int rc;

	rc = sqlite3_open16(L"\xd14c\xc2a4\xd2b8_utf16.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open16 error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	rc = sqlite3_close(db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_close error : %s\n", sqlite3_errmsg(db));
		return -1;
	}	
	return 0;
}

/***********************************************************
  testing sqlite3_exec

  CREATE TABLE과 같이 간략한 sql을 실행하는 경우에는
  sqlite3_exec() 함수를 사용한다.
  탐색기 상에서 db파일의 크기가 변화된 것을 알 수 있다.

int sqlite3_exec(
  sqlite3*,                                  // An open database 
  const char *sql,                           // SQL to be evaluated 
  int (*callback)(void*,int,char**,char**),  // Callback function 
  void *,                                    // 1st argument to callback 
  char **errmsg                              // Error msg written here
);

 ***********************************************************/
int capi_example_4()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "CREATE TABLE IF NOT EXISTS tblBookList"
		"(id INTEGER PRIMARY KEY,"
		"ISBN TEXT UNIQUE,"
		"Title TEXT,"
		"Author TEXT,"
		"Publisher TEXT,"
		"PublishDate TEXT,"
		"Price INTEGER);"
		"DROP TABLE tblBookList;";
	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_exec

  select문과 같이 결과를 받아보아야 하는 경우에는,
  callback을 사용하여 결과값들을 확인할 수 있다.
  아래 예제에서는 insert 한 다음 select를 해서 결과값을 확인해 본다.

 ***********************************************************/
int cbSelect(void* data, int ncols, char** values, char** headers)
{
	int i;
	printf("%s\n", (const char*) data);
	for(i=0;i<ncols;i++){
		printf("\t%s=%s\n", headers[i], values[i]);
	}
	return 0;
}

int capi_example_5()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "CREATE TABLE IF NOT EXISTS tblBookList"
		"(id INTEGER PRIMARY KEY,"
		"ISBN TEXT UNIQUE,"
		"Title TEXT,"
		"Author TEXT,"
		"Publisher TEXT,"
		"PublishDate TEXT,"
		"Price INTEGER);"
		"INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES('0201000001','How to spit','hydralisk','hatchery','091231',20000);"
		"SELECT * from tblBookList;";

	const char* data = "sqlite3_exec callback function called";
	rc = sqlite3_exec(db, sql, cbSelect, (void*)data, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_get_table

  sqlite3_get_table() 함수를 이용해서 select의 결과값을 알아볼 수도 있다. 
  sqlite3_get_table() 내부에서 메모리를 새로 할당하기 때문에,
  sqlite3_free_table을 이용하여 메모리 해제를 해 주어야 한다.

 ***********************************************************/
int capi_example_6()
{
	sqlite3 *db;
	char* sql;
	char** result;
	char* errmsg;
	int rows, columns;
	int rc, i, j;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "SELECT * FROM tblBookList";
	rc = sqlite3_get_table(db, sql, &result, &rows, &columns, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	for(i=0;i<=rows;i++){ // the first row means the column header.
		for(j=0;j<columns;j++){
			printf("%s, ", result[i*columns+j]);
		}
		printf("\n");
	}

	sqlite3_free_table(result);
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_prepare

  prepare, step, finalize에 대한 예제.


int sqlite3_prepare(
  sqlite3 *db,            // Database handle 
  const char *zSql,       // SQL statement, UTF-8 encoded 
  int nByte,              // Maximum length of zSql in bytes. 
  sqlite3_stmt **ppStmt,  // OUT: Statement handle 
  const char **pzTail     // OUT: Pointer to unused portion of zSql 
);

int sqlite3_step(sqlite3_stmt*);

int sqlite3_finalize(sqlite3_stmt *pStmt);

int sqlite3_column_count(sqlite3_stmt *pStmt);

 ***********************************************************/
int capi_example_7()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, columns, i;
	const char* tail;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "SELECT * FROM tblBookList";
	rc = sqlite3_prepare(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	columns = sqlite3_column_count(state);

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		for(i=0;i<columns;i++){
			printf("%s, ", sqlite3_column_text(state,i));
		}
		printf("\n");
		rc = sqlite3_step(state);
	}

	sqlite3_finalize(state);
	sqlite3_close(db);
	return 0;
}


/***********************************************************
  testing sqlite3_prepare 
  prepare로 처리한 후 tail이 남았을 경우에 대한 예제이다.
 ***********************************************************/
int capi_example_8()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, columns, i;
	const char* tail;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "SELECT * FROM tblBookList;"
		"INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES('0201000002','How to burrow','lurker','lair','100131',30000);";

	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	columns = sqlite3_column_count(state);

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		for(i=0;i<columns;i++){
			printf("%s ", sqlite3_column_text(state,i));
		}
		printf("\n");
		rc = sqlite3_step(state);
	}
	sqlite3_finalize(state);

	printf("tail : %s\n", tail);
	
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_prepare with getting information
  column 관련정보를 얻어오는 방법들에 대한 예제이다.
 ***********************************************************/
int capi_example_9()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, i, data;
	const char* tail;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "SELECT Title AS t, 10000 FROM tblBookList";
	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	int columns = sqlite3_column_count(state);
	printf("the # of columns : %d\n", columns);
	for(i=0;i<columns;i++){
		printf("[%d] column name : %s\n", i, sqlite3_column_name( state, i ));
		printf("[%d] column type : %d\n", i, sqlite3_column_type( state, i ));
		printf("[%d] column decltype : %s\n", i, sqlite3_column_decltype( state, i ));
		printf("[%d] column db name : %s\n", i, sqlite3_column_database_name( state, i ));
		printf("[%d] column table name : %s\n", i, sqlite3_column_table_name( state, i ));
		printf("[%d] column origin name : %s\n", i, sqlite3_column_origin_name( state, i ));
	}

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		data = sqlite3_data_count(state);
		printf("the # of data : %d\n", data);
		
		for(i=0;i<columns;i++){
			printf("[%d] column value : %s\n", i, sqlite3_column_text(state,i));
		}
		rc = sqlite3_step(state);
	}

	sqlite3_finalize(state);
	sqlite3_close(db);
	return 0;
}


/***********************************************************
  testing sqlite3_prepare
  parameterized query에 대한 예제이다.
 ***********************************************************/
void destructor(void* pData)
{
	printf("destructor called : %s\n", (char*)pData);
}

int capi_example_10()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, columns, i;
	const char* tail;

	char ISBN[2][20] = {"12345678","23456789"};
	char Title[2][20] = {"first","second"};
	char Author[2][20] = {"shin","woo"};
	char Publisher[2][20] = {"blog2books","xpress"};
	char PublishDate[2][20] = {"090810","090905"};
	int Price[2] = {12000,15000};

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES (?,?,?,?,?,?)";

	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	for(i=0;i<2;i++){
		sqlite3_bind_text(state, 1, ISBN[i], strlen(ISBN[i]), SQLITE_STATIC);
		sqlite3_bind_text(state, 2, Title[i], strlen(Title[i]), SQLITE_STATIC);
		sqlite3_bind_text(state, 3, Author[i], strlen(Author[i]), SQLITE_STATIC);
		sqlite3_bind_text(state, 4, Publisher[i], strlen(Publisher[i]), destructor);
		sqlite3_bind_text(state, 5, PublishDate[i], strlen(PublishDate[i]), SQLITE_TRANSIENT);
		sqlite3_bind_int(state, 6, Price[i]);

		// SQLITE_STATIC, SQLITE_TRANSIENT의 차이
		// SQLITE_STATIC의 경우인 title에 대해서만 결과값이 바뀐 것을 확인할 수 있다.
		// SQLITE_TRANSIENT의 경우에는 bind시에 값을 복사해서, 바뀌지 않음.
		strcpy(Title[i], "changed");
		strcpy(PublishDate[i], "000000");

		sqlite3_step(state);
		// sqlite3_reset을 하지 않으면, state가 reset 되지 않아서 2번째 row가 insert 되지 않는다.
		sqlite3_reset(state);
	}

	sqlite3_finalize(state);

	sql = "SELECT * FROM tblBookList";
	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	columns = sqlite3_column_count(state);

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		for(i=0;i<columns;i++){
			printf("%s, ", sqlite3_column_text(state,i));
		}
		printf("\n");
		rc = sqlite3_step(state);
	}

	sqlite3_finalize(state);
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_prepare
  numbered parameters에 대한 예제이다.
 ***********************************************************/
int capi_example_11()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, columns, i;
	const char* tail;

	char ISBN[20] = "87654321";
	char Title[20] = "IT does matter";
	char Author[20] = "Ha";
	char Publisher[20] = "xbooks";
	char PublishDate[20] = "091011";
	int Price = 9000;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES (?1,?3,?5,?7,?9,?11)";
	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_bind_text(state, 1, ISBN, strlen(ISBN), SQLITE_STATIC);
	sqlite3_bind_text(state, 3, Title, strlen(Title), SQLITE_STATIC);
	sqlite3_bind_text(state, 5, Author, strlen(Author), SQLITE_STATIC);
	sqlite3_bind_text(state, 7, Publisher, strlen(Publisher), SQLITE_STATIC);
	sqlite3_bind_text(state, 9, PublishDate, strlen(PublishDate), SQLITE_STATIC);
	sqlite3_bind_int(state, 11, 9000);

	sqlite3_step(state);
	sqlite3_finalize(state);

	sql = "SELECT * FROM tblBookList";
	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	columns = sqlite3_column_count(state);

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		for(i=0;i<columns;i++){
			printf("%s, ", sqlite3_column_text(state,i));
		}
		printf("\n");
		rc = sqlite3_step(state);
	}

	sqlite3_finalize(state);
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_prepare
  named parameters에 대한 예제이다.
 ***********************************************************/
int capi_example_12()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, columns, i;
	const char* tail;

	char ISBN[20] = "98765432";
	char Title[20] = "IT doesn't matter";
	char Author[20] = "Lee";
	char Publisher[20] = "xbooks";
	char PublishDate[20] = "091111";
	int Price = 9000;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sql = "INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES (:isbn,:title,:author,:publisher,:publishdate,:price)";
	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_bind_text(state, sqlite3_bind_parameter_index(state,":isbn"), ISBN, strlen(ISBN), SQLITE_STATIC);
	sqlite3_bind_text(state, sqlite3_bind_parameter_index(state,":title"), Title, strlen(Title), SQLITE_STATIC);
	sqlite3_bind_text(state, sqlite3_bind_parameter_index(state,":author"), Author, strlen(Author), SQLITE_STATIC);
	sqlite3_bind_text(state, sqlite3_bind_parameter_index(state,":publisher"), Publisher, strlen(Publisher), SQLITE_STATIC);
	sqlite3_bind_text(state, sqlite3_bind_parameter_index(state,":publishdate"), PublishDate, strlen(PublishDate), SQLITE_STATIC);
	sqlite3_bind_int(state, sqlite3_bind_parameter_index(state,":price"), 9000);

	sqlite3_step(state);
	sqlite3_finalize(state);

	sql = "SELECT * FROM tblBookList";
	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	columns = sqlite3_column_count(state);

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		for(i=0;i<columns;i++){
			printf("%s, ", sqlite3_column_text(state,i));
		}
		printf("\n");
		rc = sqlite3_step(state);
	}

	sqlite3_finalize(state);
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_busy_handler
 ***********************************************************/
static int busy(void *handle, int unused)
{
	printf("[%d] busy handler is called\n", GetCurrentThreadId());
	return 0;
}


DWORD WINAPI InsertThreadFunction(LPVOID pvoid)
{ 
	char* isbn = (char*)pvoid;
	printf("[%d] try to insert %s\n", GetCurrentThreadId(), isbn);

	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc;
	const char* tail;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	// busy handler 등록
	sqlite3_busy_handler(db, busy, NULL);
	
	// timeout을 길게 설정하면 lock이 발생안함.
	sqlite3_busy_timeout(db, 2000);

	sql = "INSERT INTO tblBookList(ISBN) VALUES (:isbn)";

	rc = sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_bind_text(state, sqlite3_bind_parameter_index(state,":isbn"), isbn, strlen(isbn), SQLITE_TRANSIENT );
	rc = sqlite3_step(state);
	if (rc<SQLITE_ROW) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_prepare error : %s\n", sqlite3_errmsg(db));
	}

	sqlite3_finalize(state);

	return 0;
}

int print_sql(sqlite3* db, const char* sql)
{
	char** result;
	char* errmsg;
	int rows, columns;
	int rc, i, j;

	rc = sqlite3_get_table(db, sql, &result, &rows, &columns, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	for(i=0;i<=rows;i++){ // the first row means the column header.
		for(j=0;j<columns;j++){
			printf("%s, ", result[i*columns+j]);
		}
		printf("\n");
	}

	sqlite3_free_table(result);
	return 0;
}

int capi_example_13()
{
	int i;
	const int MAX_THREAD = 2;
	HANDLE dbThreads[MAX_THREAD];
	char ISBN[2][20] = {"02345678", "02876543"};

	for(i=0;i<MAX_THREAD;i++){
		 dbThreads[i] = CreateThread( NULL , 0 , InsertThreadFunction , (LPVOID)ISBN[i] , 0 , NULL );
	}

	WaitForMultipleObjects( MAX_THREAD, dbThreads, TRUE, INFINITE );

	for(i=0;i<MAX_THREAD;i++){
		CloseHandle( dbThreads[i] );
	}

	// select results
	sqlite3 *db;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	print_sql(db, "SELECT * FROM tblBookList");

	sqlite3_close(db);

	return 0;
}


/***********************************************************
  testing sqlite3_commit_hook
 ***********************************************************/
int cbCommit( void *data )
{
	printf("commit callback function is called\n");
	return SQLITE_OK;
}

int capi_example_14()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_commit_hook( db, cbCommit, NULL );

	sql = "BEGIN TRANSACTION;"
		"INSERT INTO tblBookList(ISBN) VALUES ('0987654321');"
		"COMMIT TRANSACTION;";

	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	sqlite3_close(db);
	return 0;
}


/***********************************************************
  testing sqlite3_rollback_hook
 ***********************************************************/
void cbRollback( void *data )
{
	printf("rollback callback function is called\n");
}

int capi_example_15()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_rollback_hook( db, cbRollback, NULL );

	sql = "BEGIN TRANSACTION;"
		"INSERT INTO tblBookList(ISBN) VALUES ('1234567890');"
		"ROLLBACK TRANSACTION;";

	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	sqlite3_close(db);
	return 0;
}


/***********************************************************
  testing sqlite3_commitback_hook & rollback_hook
  commit_hook에서 0이외의 다른 값을 반환하게 되면,
  rollback으로 처리되는 경우에 대한 테스트.
 ***********************************************************/
int cbCommit2( void *data )
{
	printf("commit callback function is called\n");
	return SQLITE_ERROR;
}

void cbRollback2( void *data )
{
	printf("rollback callback function is called\n");
}

int capi_example_16()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_commit_hook( db, cbCommit2, NULL );
	sqlite3_rollback_hook( db, cbRollback2, NULL );

	sql = "BEGIN TRANSACTION;"
		"INSERT INTO tblBookList(ISBN) VALUES ('1234567890');"
		"COMMIT TRANSACTION;";

	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		//return -1; // this test case should be rollbacked.
	}

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_update_hook
 ***********************************************************/
void cbUpdate( void *data, int action, char const *db_name, char const *table_name, sqlite_int64 rowid )
{
	printf("update callback function is called\n"
		"action:%d, db:%s, table:%s, rowid:%d\n", action, db_name, table_name, rowid);
}

int capi_example_17()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_update_hook( db, cbUpdate, NULL );

	sql = "INSERT INTO tblBookList(ISBN) VALUES ('1234567890');"
		"DELETE FROM tblBookList WHERE ISBN='1234567890';";

	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	sqlite3_close(db);
	return 0;
}


/***********************************************************
  testing sqlite3_set_authorizer
 ***********************************************************/
int cbAuth(void* data, int code, const char* event_arg1, const char* event_arg2,
		   const char* db_name, const char* tv_name)
{
	printf("auth callback function is called\n"
		"\tcode : %d\n"
		"\tevent_arg1 : %s\n"
		"\tevent_arg2 : %s\n"
		"\tdb_name : %s\n"
		"\ttrigger/view name : %s\n",
		code, event_arg1, event_arg2, db_name, tv_name);

	if (code==SQLITE_DELETE) {
		printf("this code is ignored !!\n");
		return SQLITE_IGNORE;
	}
	else {
		return SQLITE_OK;
	}
}

int capi_example_18()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_set_authorizer( db, cbAuth, NULL );

	sql = "INSERT INTO tblBookList(ISBN) VALUES ('1234567890');"
		"DELETE FROM tblBookList;";

	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_mprintf
 ***********************************************************/
int capi_example_19()
{
	sqlite3 *db;
	char sql[255];
	char* title;
	char* errmsg;
	char* sql2;
	char* sql3;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	title = "don't stop me now";
	sprintf(sql, "INSERT INTO tblBookList(ISBN,Title,Price) VALUES ('1234567890','%s',10000)",title);
	printf("%s\n", sql);

	rc = sqlite3_exec(db, sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
	}

	sql2 = sqlite3_mprintf("INSERT INTO tblBookList(ISBN,Title,Price) VALUES ('0123456789','%q',10000)",title);
	printf("%s\n", sql2);
	sql3 = sqlite3_mprintf("INSERT INTO tblBookList(ISBN,Title,Price) VALUES ('0123456789',%Q,10000)",title);
	printf("%s\n", sql3);

	rc = sqlite3_exec(db, sql2, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
	}

	sqlite3_free(sql2);
	sqlite3_free(sql3);
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_vmprintf
 ***********************************************************/
int vm_exec(sqlite3* db, const char* sql, ...)
{
	char* errmsg;
	char* escaped_sql;
	va_list ap;
	int rc;

	va_start(ap, sql);
	escaped_sql = sqlite3_vmprintf(sql, ap);
	va_end(ap);
	printf("%s\n",escaped_sql);

	rc = sqlite3_exec(db, escaped_sql, NULL, NULL, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return rc;
	}

	sqlite3_free(escaped_sql);
	return 0;
}

int capi_example_20()
{
	sqlite3 *db;
	char* title;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	title = "don't stop me now";
	rc = vm_exec(db, "INSERT INTO tblBookList(ISBN,Title,Price) VALUES('%q', '%q', 10000);", "0987612345", title);
	if (SQLITE_OK!=rc) {
		return -1;
	}

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing user-defined function
 ***********************************************************/
void new_function(sqlite3_context* ctx, int nargs, sqlite3_value** values)
{
	printf("nargs: %d\n", nargs);

	for(int i=0;i<nargs;i++){
		printf("[%d] values: %s\n", i, sqlite3_value_text(values[i]));
	}
}

int capi_example_21()
{
	sqlite3 *db;
	char* sql;
	char** result;
	char* errmsg;
	int rows, columns;
	int rc, i, j;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_create_function(db, "new", -1, SQLITE_UTF8, NULL, new_function, NULL, NULL);

	sql = "SELECT new(100,200,300)";
	rc = sqlite3_get_table(db, sql, &result, &rows, &columns, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	for(i=0;i<=rows;i++){ // the first row means the column header.
		for(j=0;j<columns;j++){
			printf("%s, ", result[i*columns+j]);
		}
		printf("\n");
	}

	sqlite3_free_table(result);	
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing user-defined function - aggregation
 ***********************************************************/
// 합 정보를 저장해 놓을 구조체.
typedef struct {
    int total;
} data;

void step_function(sqlite3_context* ctx, int ncols, sqlite3_value** values)
{
	int tmp;
	data* pData = (data*)sqlite3_aggregate_context(ctx, sizeof(data));

	if (sqlite3_aggregate_count(ctx)==1)
		pData->total = 0;

	if (sqlite3_value_type(values[0]) != SQLITE_INTEGER) {
		char* errmsg = "this function supports only integer.";
		sqlite3_result_error(ctx, errmsg, strlen(errmsg));
		return;
	}

	tmp = sqlite3_value_int(values[0]);
	pData->total += tmp;

	printf("[step:%d]\n", tmp);
}

void final_function(sqlite3_context* ctx)
{
	data* pData = (data*)sqlite3_aggregate_context(ctx, sizeof(data));
	sqlite3_result_int(ctx, pData->total);
}

int capi_example_22()
{
	sqlite3 *db;
	char* sql;
	char** result;
	char* errmsg;
	int rows, columns;
	int rc, i, j;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_create_function(db, "total", -1, SQLITE_UTF8, NULL, NULL, step_function, final_function);

	sql = "SELECT total(Price) FROM tblBookList";
	rc = sqlite3_get_table(db, sql, &result, &rows, &columns, &errmsg);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_exec error : %s\n", errmsg);
		return -1;
	}

	for(i=0;i<=rows;i++){ // the first row means the column header.
		for(j=0;j<columns;j++){
			printf("%s, ", result[i*columns+j]);
		}
		printf("\n");
	}

	sqlite3_free_table(result);	
	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing collate function
 ***********************************************************/
int myCompare(void* data, int len1, const void* in1,
			int len2, const void* in2)
{
	int i, j, sum1, sum2;
	char* str1 = (char*)in1;
	char* str2 = (char*)in2;
	sum1 = sum2 = 0;
	for(i=0; i<len1-1; i++){
		sum1 += abs(str1[i]-str1[i+1]);
	}
	for(j=0; j<len2-1; j++){
		sum2 += abs(str2[j]-str2[j+1]);
	}
	printf("collate result: sum1=%d, sum2=%d\n", sum1, sum2);
	return sum1 < sum2 ? -1:1;
}

int capi_example_23()
{
	sqlite3 *db;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	sqlite3_create_collation(db, "near", SQLITE_UTF8, NULL, myCompare);

	print_sql(db, "SELECT * FROM tblBookList ORDER BY ISBN COLLATE near");

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_complete
 ***********************************************************/
int capi_example_24()
{
	char* sql;
	int complete;

	sql = "CREATE TABLE IF NOT EXISTS tblAuthor (id INTEGER PRIMARY KEY, Name text);";
	complete = sqlite3_complete(sql);
	printf("%s : %d\n", sql, complete);

	sql = "CREATE TABLE IF NOT EXISTS tblAuthor";
	complete = sqlite3_complete(sql);
	printf("%s : %d\n", sql, complete);

	sql = "WRONG SYNTAX;";
	complete = sqlite3_complete(sql);
	printf("%s : %d\n", sql, complete);
	
	return 0;
}

/***********************************************************
  testing sqlite3_get_autocommit
 ***********************************************************/
int capi_example_25()
{
	sqlite3 *db;
	char* sql;
	char* errmsg;
	int rc;

	rc = sqlite3_open("test.db", &db);
	if (SQLITE_OK!=rc) {
		fprintf(stderr, "rc = %d\n", rc);
		fprintf(stderr, "sqlite3_open error : %s\n", sqlite3_errmsg(db));
		return -1;
	}

	printf("1. sqlite3 auto commit : %d\n", sqlite3_get_autocommit(db) );

	sql = "BEGIN;"
		"INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES('0201000001','iPhone Advanced Programming','unknown','kiwibook','100322',25000);";
	sqlite3_exec(db, sql, NULL, NULL, &errmsg);

	printf("2. sqlite3 auto commit : %d\n", sqlite3_get_autocommit(db) );

	sqlite3_exec(db, "COMMIT;", NULL, NULL, &errmsg);

	printf("3. sqlite3 auto commit : %d\n", sqlite3_get_autocommit(db) );

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_last_insert_rowid
 ***********************************************************/
int capi_example_26()
{
	sqlite3 *db;
	char* sql;

	sqlite3_open("test.db", &db);

	print_sql(db, "SELECT * FROM tblBookList");

	// row가 있으나, 최근 insert된 내용이 없으므로, 0
	printf("last_insert_rowid : %d\n", sqlite3_last_insert_rowid(db));

	sql = "INSERT INTO tblBookList(ISBN,Title,Author,Publisher,PublishDate,Price)"
		" VALUES('0201000002','iPhone Programming','soudz','wikibook','091031',30000);";
	sqlite3_exec(db, sql, NULL, NULL, NULL);

	// insert가 성공했으므로 rowid = 3+1
	printf("last_insert_rowid : %d\n", sqlite3_last_insert_rowid(db));

	// 다른 테이블에 대해 insert하면 ?
	sql = "DROP TABLE IF EXISTS tblTest;"
		"CREATE TABLE IF NOT EXISTS tblTest (id INTEGER);"
		"INSERT INTO tblTest(id) VALUES(10);";
	sqlite3_exec(db, sql, NULL, NULL, NULL);

	printf("last_insert_rowid : %d\n", sqlite3_last_insert_rowid(db));

	sqlite3_close(db);
	return 0;
}

/***********************************************************
  testing sqlite3_libversion & sqlite3_libversion_number
 ***********************************************************/
int capi_example_27()
{
	printf("sqlite3_libversion : %s\n", sqlite3_libversion());
	printf("sqlite3_libversion_number : %d\n", sqlite3_libversion_number());

	return 0;
}

/***********************************************************
  testing sqlite3_memory_used & sqlite3_memory_highwater
 ***********************************************************/
int capi_example_28()
{
	sqlite3 *db;
	sqlite3_open("test.db", &db);

	printf("sqlite3 mem used : %d\n", sqlite3_memory_used() );
	printf("sqlite3 mem highwater : %d\n", sqlite3_memory_highwater(0) );

	sqlite3_close(db);

	return 0;
}

/***********************************************************
  testing sqlite3_sql
 ***********************************************************/
int capi_example_29()
{
	sqlite3 *db;
	char* sql;
	sqlite3_stmt* state;
	int rc, columns, i;
	const char* tail;

	sqlite3_open("test.db", &db);

	sql = "SELECT * FROM tblBookList";
	sqlite3_prepare_v2(db, sql, strlen(sql), &state, &tail); // sqlite3_prepare_v2 함수 사용!
	columns = sqlite3_column_count(state);

	rc = sqlite3_step(state);
	while( rc==SQLITE_ROW ){
		for(i=0;i<columns;i++){
			printf("%s, ", sqlite3_column_text(state,i));
		}
		printf("\n");
		rc = sqlite3_step(state);
	}
	printf("sqlite3_sql : %s\n", sqlite3_sql(state) );

	sqlite3_finalize(state);
	sqlite3_close(db);
	return 0;
}

int capi_example_transaction()
{
	sqlite3 *db;
	char sql[255];
	int i;

	sqlite3_open("test.db", &db);
	sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS tblTest(id int);", NULL, NULL, NULL);

	// without transactions : Transaction을 사용하지 않았습니다.
	clock_t start = clock();

	for(i=0;i<1000;i++){
		sprintf(sql, "INSERT INTO tblTest(id) VALUES (%d);", i);
		sqlite3_exec(db, sql, NULL, NULL, NULL);
	}

	clock_t end = clock();
    double msec = 1000.0 * (end - start) / CLOCKS_PER_SEC;
	printf("Elapsed time : %.1f ms\n", msec);

	// with transactions : INSERT를 BEGIN, END로 감쌌습니다.
	start = clock();

	sqlite3_exec(db, "BEGIN TRANSACTION;", NULL, NULL, NULL);
	for(i=0;i<1000;i++){
		sprintf(sql, "INSERT INTO tblTest(id) VALUES (%d);", i);
		sqlite3_exec(db, sql, NULL, NULL, NULL);
	}
	sqlite3_exec(db, "END TRANSACTION;", NULL, NULL, NULL);

	end = clock();
    msec = 1000.0 * (end - start) / CLOCKS_PER_SEC;
	printf("Elapsed time : %.1f ms\n", msec);

	sqlite3_close(db);
	return 0;
}

int capi_example_memorydb()
{
	sqlite3 *db;
	char sql[255];
	int i;

	// 일반적인 파일 DB를 사용하여 INSERT 수행
	sqlite3_open("test.db", &db);
	sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS tblTest(id int);", NULL, NULL, NULL);

	clock_t start = clock();

	for(i=0;i<100;i++){
		sprintf(sql, "INSERT INTO tblTest(id) VALUES (%d);", i);
		sqlite3_exec(db, sql, NULL, NULL, NULL);
	}

	clock_t end = clock();
    double msec = 1000.0 * (end - start) / CLOCKS_PER_SEC;
	printf("Elapsed time : %.1f ms\n", msec);

	// MEMORY DB를 사용하여 INSERT 수행
	sqlite3_exec(db, "ATTACH DATABASE ':memory:' AS memdb;", NULL, NULL, NULL);
	sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS memdb.tblTest(id int);", NULL, NULL, NULL);

	start = clock();

	for(i=0;i<100;i++){
		sprintf(sql, "INSERT INTO memdb.tblTest(id) VALUES (%d);", i);
		sqlite3_exec(db, sql, NULL, NULL, NULL);
	}

	end = clock();
    msec = 1000.0 * (end - start) / CLOCKS_PER_SEC;
	printf("Elapsed time : %.1f ms\n", msec);

	// check normally inserted.
	//print_sql(db, "SELECT * FROM memdb.tblTest;");

	sqlite3_close(db);
	return 0;
}

int capi_example_auto_vacuum()
{
	sqlite3 *db;
	char sql[255];
	int i;

	// auto_vacuum = 0 : auto_vacuum 모드를 끕니다.
	sqlite3_open("no_vacuum.db", &db);
	sqlite3_exec(db, 
		"PRAGMA auto_vacuum=0;" // auto_vacuum을 OFF.
		"CREATE TABLE IF NOT EXISTS tblTest(id int);", 
		NULL, NULL, NULL);

	for(i=0;i<1000;i++){
		sprintf(sql, "INSERT INTO tblTest(id) VALUES (%d);", i);
		sqlite3_exec(db, sql, NULL, NULL, NULL);
	}

	sqlite3_exec(db, "DELETE FROM tblTest WHERE id>=0;", NULL, NULL, NULL);
	sqlite3_close(db);

	// auto_vacuum = 1 : auto_vacuum 모드를 켭니다.
	sqlite3_open("vacuum.db", &db);
	sqlite3_exec(db, 
		"PRAGMA auto_vacuum=1;" // auto_vacuum을 ON.
		"CREATE TABLE IF NOT EXISTS tblTest(id int);",
		NULL, NULL, NULL);

	for(i=0;i<1000;i++){
		sprintf(sql, "INSERT INTO tblTest(id) VALUES (%d);", i);
		sqlite3_exec(db, sql, NULL, NULL, NULL);
	}

	sqlite3_exec(db, "DELETE FROM tblTest WHERE id>=0;", NULL, NULL, NULL);
	sqlite3_close(db);

	return 0;
}
