#include <main2/the_main2.hpp>

#include <string>

std::string the_main2() {
  return std::string() + "m1=" + m1() + ",m2=" + m2() + ",m3=" + m3() + ",the_main2!";
}
