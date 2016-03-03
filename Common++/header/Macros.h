#ifndef PCAPPP_MACROS
#define PCAPPP_MACROS

#if defined(WIN32) && defined(COMPILE_DYNAMIC)
	#if 1
		#define PCAPPP_EXPORT __declspec(dllexport)
	#else // not 1
		#define PCAPPP_EXPORT __declspec(dllimport)
	#endif // 1
#else // not (WIN32 && COMPILE_DYNAMIC)
	#define PCAPPP_EXPORT
#endif // WIN32 && COMPILE_DYNAMIC
#endif /* PCAPPP_MACROS */
