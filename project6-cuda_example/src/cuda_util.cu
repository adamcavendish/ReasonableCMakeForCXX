#include <cstdio>
#include <cstdlib>

#include <project6/cuda_util.hpp>

void cuda_eexit(cudaError_t err) {
  if (err != cudaSuccess) {
    fprintf(stderr, "cuda error: %s\n", cudaGetErrorString(err));
    exit(EXIT_FAILURE);
  }
}
