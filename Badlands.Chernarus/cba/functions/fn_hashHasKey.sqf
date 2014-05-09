#include "script_hashes.hpp"
#include "script_macros_common.hpp"
PARAMS_2(_hash,_key);

_key in (_hash select HASH_KEYS); // Return.
