#include <cstdio>
#include <cassert>
#include <string>

#include <module1/m1.hpp>

int main() {
  assert(std::string("m1") == m1());
  printf("test2_m1 Success!\n");
  return 0;
}
