// STL
#include <algorithm>
// C-Standard
#include <cassert>
#include <cmath>
#include <cstdio>
#include <cstdlib>

#include <project6/cuda_util.hpp>

__global__ void vecAdd(const float *a, const float *b, float *c, int n) {
  int id = blockDim.x * blockIdx.x + threadIdx.x;

  if (id < n)
    c[id] = a[id] + b[id];
}

int main(int argc, char *argv[]) {
  int n = 100000;

  auto *h_a = new float[n];
  auto *h_b = new float[n];
  auto *h_c = new float[n];

  float *d_a = nullptr;
  float *d_b = nullptr;
  float *d_c = nullptr;
  cuda_eexit(cudaMalloc(&d_a, sizeof(float)*n));
  cuda_eexit(cudaMalloc(&d_b, sizeof(float)*n));
  cuda_eexit(cudaMalloc(&d_c, sizeof(float)*n));

  for (int i = 0; i < n; i++) {
    h_a[i] = sin(i)*sin(i);
    h_b[i] = cos(i)*cos(i);
  }

  cuda_eexit(cudaMemcpy(d_a, h_a, sizeof(float)*n, cudaMemcpyHostToDevice));
  cuda_eexit(cudaMemcpy(d_b, h_b, sizeof(float)*n, cudaMemcpyHostToDevice));

  int threadsPerBlock = 256;
  int blocksPerGrid =(n + threadsPerBlock - 1) / threadsPerBlock;
  vecAdd<<<blocksPerGrid, threadsPerBlock>>>(d_a, d_b, d_c, n);
  cuda_eexit(cudaGetLastError());

  cuda_eexit(cudaMemcpy(h_c, d_c, sizeof(float)*n, cudaMemcpyDeviceToHost));

  float sum = std::accumulate(h_c, h_c + n, 0.f);
  printf("final result: %f\n", sum / n);

  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);
  delete h_a;
  delete h_b;
  delete h_c;

  return 0;
}
