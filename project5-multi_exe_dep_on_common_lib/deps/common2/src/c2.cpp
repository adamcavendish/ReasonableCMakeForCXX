#include <string>

#include <common1/c1.hpp>
#include <common2/c2.hpp>

std::string g_c2 = "c2";

std::string c2() { return g_c1 + ' ' + g_c2; }
