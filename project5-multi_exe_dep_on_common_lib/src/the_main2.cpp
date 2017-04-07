#include <main2/the_main2.hpp>
#include <common1/c1.hpp>
#include <common2/c2.hpp>
#include <module3/m3.hpp>

#include <string>

std::string the_main2() {
  return std::string() + "c1=" + c1() + ",c2=" + c2() + ",m3=" + m3() + ",the_main2!";
}
