#include <check.h>
#include <stdlib.h>
#include <stdint.h>

typedef struct{
	char* ptr;
	int num;
} testStruct;

static char* p = NULL;
static testStruct s = {0};

START_TEST(ptr_test)
{
	ck_assert_ptr_null(p);
}
END_TEST

START_TEST(struct_test)
{
	ck_assert_ptr_null(s.ptr);
	ck_assert_int_eq(s.num, 0);
}
END_TEST

int main(void)
{
	return 0;
}
