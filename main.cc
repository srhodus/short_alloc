#include <iostream>
#include <vector>
#include <string>
#include "short_alloc.h"

// Create a vector<T> template with a small buffer of 200 bytes.
//   Note for vector it is possible to reduce the alignment requirements
//   down to alignof(T) because vector doesn't allocate anything but T's.
//   And if we're wrong about that guess, it is a compile-time error, not
//   a run time error.
template <class T, std::size_t BufSize = 32>
using SmallVector = std::vector<T, short_alloc<T, BufSize, alignof(T)>>;

int main() {
    SmallVector<int>::allocator_type::arena_type a;
    SmallVector<int> sv{a};
    for (int i = 0; i < 10; i++)
        sv.push_back(i);
    return 0;
}
