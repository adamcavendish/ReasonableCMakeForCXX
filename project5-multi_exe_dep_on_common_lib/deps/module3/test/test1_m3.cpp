#include <cstdio>
#include <cassert>
#include <string>

#include <module3/m3.hpp>

int main() {
  assert(std::string("m3") == m3());
  printf("test1_m3 Success!\n");
  return 0;
}
