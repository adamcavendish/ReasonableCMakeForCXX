#include <main1/the_main1.hpp>
#include <main2/the_main2.hpp>
#include <cassert>

int main() {
  assert(std::string("c1=c1,c2=c1 c2,m3=m3,the_main1!") == the_main1());
  assert(std::string("c1=c1,c2=c1 c2,m3=m3,the_main2!") == the_main2());

  return 0;
}
