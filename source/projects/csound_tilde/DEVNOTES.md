# Fixes and Changes


- [x] pattern of `using namespace std`: removed all `using namespace std` statements and converted unqualified terms to qualified.

- [x] ambiguity between `std::byte` (added in c++ 17) and `typedef byte` in `definitions.h`: the former helped but also changed definitions.h `byte` to `csbyte`


- [x] use of `auto_ptr`, which was removed in c++17, in `csound~.cpp`: converted to `std::unique_ptr`.

