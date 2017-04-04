#include <cstdio>
#include <cassert>
#include <string>

#include <module2/m2.hpp>

int main() {
  assert(std::string("m2") == m2());
  printf("test1_m2 Success!\n");
  return 0;
}
