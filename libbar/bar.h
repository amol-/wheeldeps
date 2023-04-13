#ifndef bar_h__
#define bar_h__

#undef MODULE_API
#ifdef _WIN32
#  ifdef MODULE_API_EXPORTS
#    define MODULE_API __declspec(dllexport)
#  else
#    define MODULE_API __declspec(dllimport)
#  endif
#else
#  define MODULE_API
#endif
 
MODULE_API extern void bar(void);
 
#endif  // bar_h__
