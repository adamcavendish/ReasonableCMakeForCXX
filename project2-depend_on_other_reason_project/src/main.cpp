#include <main1/the_main1.hpp>
#include <main2/the_main2.hpp>
#include <cstdio>

int main() {
  printf("project2 call the_main1: %s\n", the_main1().c_str());
  printf("project2 call the_main2: %s\n", the_main2().c_str());

  return 0;
}
