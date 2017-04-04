#include <cstdio>
#include <cassert>
#include <string>

#include <common2/c2.hpp>

int main() {
  assert(std::string("c1 c2") == c2());
  printf("test2_c2 Success!\n");
  return 0;
}
