// sqlite3_capi_examples.cpp : Defines the entry point for the console application.
//

#include "stdafx.h"
#include "capi_examples.h"

#define TEST(x) \
	if (x()) fprintf(stderr, "[TestCase] " #x " : FAIL!!!!!\n"); \
	else printf("[TestCase] " #x " : PASS\n");

int _tmain(int argc, _TCHAR* argv[])
{
	// open & close
	TEST(capi_example_1);
	TEST(capi_example_2);
	TEST(capi_example_3);

	// exec
	TEST(capi_example_4);
	TEST(capi_example_5);

	// get_table
	TEST(capi_example_6);

	// prepare
	TEST(capi_example_7);
	TEST(capi_example_8);
	TEST(capi_example_9);
	TEST(capi_example_10);
	TEST(capi_example_11);
	TEST(capi_example_12);

	// busy 
	TEST(capi_example_13);

	// hooks
	TEST(capi_example_14);
	TEST(capi_example_15);
	TEST(capi_example_16);
	TEST(capi_example_17);
	TEST(capi_example_18);

	// mprintf, vmprintf
	TEST(capi_example_19);
	TEST(capi_example_20);

	// user-defined function
	TEST(capi_example_21);
	TEST(capi_example_22);

	// collation
	TEST(capi_example_23);

	// complete
	TEST(capi_example_24);

	// auto commit
	TEST(capi_example_25);

	// last insert rowid
	TEST(capi_example_26);

	// sqlite3_libversion & sqlite3_libversion_number
	TEST(capi_example_27);

	// sqlite3_memory_used & sqlite3_memory_highwater
	TEST(capi_example_28);

	// sqlite3_sql
	TEST(capi_example_29);

	// transaction example
	TEST(capi_example_transaction);

	// memory db example
	TEST(capi_example_memorydb);

	// auto_vacuum example
	TEST(capi_example_auto_vacuum);

	return 0;
}

