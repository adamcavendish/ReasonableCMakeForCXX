#include <cstdio>
#include <cassert>
#include <string>

#include <common1/c1.hpp>

int main() {
  assert(std::string("c1") == c1());
  printf("test1_c1 Success!\n");
  return 0;
}
