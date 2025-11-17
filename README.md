# SPSC Queue
Implementation of a lock-free single-producer-single-consumer queue in x86-64.

Constructors and member functions can be accessed through a C++ interface.

Requires `uint64_t` to be name-mangled to `m`.


## Build
```
bazel run //spsc_queue:example
```

## Testing
All testing was done with `spsc_queue:example`.

Can't get GTests to compile due to relocation issues I believe.

