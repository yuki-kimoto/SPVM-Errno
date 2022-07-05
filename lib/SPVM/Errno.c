#include "spvm_native.h"

#include <errno.h>

int32_t SPVM__Errno__errno(SPVM_ENV* env, SPVM_VALUE* stack) {
  
  stack[0].ival = errno;
  
  return 0;
}
