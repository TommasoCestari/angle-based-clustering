# 0 "c/src/main.c"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "c/src/main.c"
# 1 "C:/msys64/mingw64/include/stdio.h" 1 3
# 9 "C:/msys64/mingw64/include/stdio.h" 3
# 1 "C:/msys64/mingw64/include/corecrt_stdio_config.h" 1 3
# 10 "C:/msys64/mingw64/include/corecrt_stdio_config.h" 3
# 1 "C:/msys64/mingw64/include/corecrt.h" 1 3
# 10 "C:/msys64/mingw64/include/corecrt.h" 3
# 1 "C:/msys64/mingw64/include/_mingw.h" 1 3
# 10 "C:/msys64/mingw64/include/_mingw.h" 3
# 1 "C:/msys64/mingw64/include/_mingw_mac.h" 1 3
# 108 "C:/msys64/mingw64/include/_mingw_mac.h" 3
             
# 117 "C:/msys64/mingw64/include/_mingw_mac.h" 3
             
# 326 "C:/msys64/mingw64/include/_mingw_mac.h" 3
       
# 405 "C:/msys64/mingw64/include/_mingw_mac.h" 3
       
# 11 "C:/msys64/mingw64/include/_mingw.h" 2 3
# 1 "C:/msys64/mingw64/include/_mingw_secapi.h" 1 3
# 12 "C:/msys64/mingw64/include/_mingw.h" 2 3
# 306 "C:/msys64/mingw64/include/_mingw.h" 3
# 1 "C:/msys64/mingw64/include/vadefs.h" 1 3
# 9 "C:/msys64/mingw64/include/vadefs.h" 3
# 1 "C:/msys64/mingw64/include/_mingw.h" 1 3
# 685 "C:/msys64/mingw64/include/_mingw.h" 3
# 1 "C:/msys64/mingw64/include/sdks/_mingw_ddk.h" 1 3
# 686 "C:/msys64/mingw64/include/_mingw.h" 2 3
# 10 "C:/msys64/mingw64/include/vadefs.h" 2 3




#pragma pack(push,_CRT_PACKING)
# 24 "C:/msys64/mingw64/include/vadefs.h" 3
  
# 24 "C:/msys64/mingw64/include/vadefs.h" 3
 typedef __builtin_va_list __gnuc_va_list;






  typedef __gnuc_va_list va_list;
# 103 "C:/msys64/mingw64/include/vadefs.h" 3
#pragma pack(pop)
# 307 "C:/msys64/mingw64/include/_mingw.h" 2 3
# 604 "C:/msys64/mingw64/include/_mingw.h" 3
void __attribute__((__cdecl__)) __debugbreak(void);
extern __inline__ __attribute__((__always_inline__,__gnu_inline__)) void __attribute__((__cdecl__)) __debugbreak(void)
{



  __asm__ __volatile__("int {$}3":);





}
# 625 "C:/msys64/mingw64/include/_mingw.h" 3
void __attribute__((__cdecl__)) __attribute__ ((__noreturn__)) __fastfail(unsigned int code);
extern __inline__ __attribute__((__always_inline__,__gnu_inline__)) void __attribute__((__cdecl__)) __attribute__ ((__noreturn__)) __fastfail(unsigned int code)
{




  __asm__ __volatile__("int {$}0x29"::"c"(code));






  __builtin_unreachable();
}
# 665 "C:/msys64/mingw64/include/_mingw.h" 3
const char *__mingw_get_crt_info (void);
# 11 "C:/msys64/mingw64/include/corecrt.h" 2 3




#pragma pack(push,_CRT_PACKING)
# 35 "C:/msys64/mingw64/include/corecrt.h" 3
__extension__ typedef unsigned long long size_t;
# 45 "C:/msys64/mingw64/include/corecrt.h" 3
__extension__ typedef long long ssize_t;






typedef size_t rsize_t;
# 62 "C:/msys64/mingw64/include/corecrt.h" 3
__extension__ typedef long long intptr_t;
# 75 "C:/msys64/mingw64/include/corecrt.h" 3
__extension__ typedef unsigned long long uintptr_t;
# 88 "C:/msys64/mingw64/include/corecrt.h" 3
__extension__ typedef long long ptrdiff_t;
# 98 "C:/msys64/mingw64/include/corecrt.h" 3
typedef unsigned short wchar_t;







typedef unsigned short wint_t;
typedef unsigned short wctype_t;





typedef int errno_t;




typedef long __time32_t;




__extension__ typedef long long __time64_t;
# 138 "C:/msys64/mingw64/include/corecrt.h" 3
typedef __time64_t time_t;
# 157 "C:/msys64/mingw64/include/corecrt.h" 3
__attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _invalid_parameter_noinfo(void);
__attribute__ ((__dllimport__)) __attribute__ ((__noreturn__)) void __attribute__((__cdecl__)) _invalid_parameter_noinfo_noreturn(void);
__attribute__ ((__dllimport__)) __attribute__ ((__noreturn__)) void __attribute__((__cdecl__)) _invoke_watson(const wchar_t *expression, const wchar_t *function_name, const wchar_t *file_name, unsigned int line_number, uintptr_t reserved);
# 437 "C:/msys64/mingw64/include/corecrt.h" 3
struct threadlocaleinfostruct;
struct threadmbcinfostruct;
typedef struct threadlocaleinfostruct *pthreadlocinfo;
typedef struct threadmbcinfostruct *pthreadmbcinfo;
struct __lc_time_data;

typedef struct localeinfo_struct {
  pthreadlocinfo locinfo;
  pthreadmbcinfo mbcinfo;
} _locale_tstruct,*_locale_t;



typedef struct tagLC_ID {
  unsigned short wLanguage;
  unsigned short wCountry;
  unsigned short wCodePage;
} LC_ID,*LPLC_ID;




typedef struct threadlocaleinfostruct {





  int refcount;
  unsigned int lc_codepage;
  unsigned int lc_collate_cp;
  unsigned long lc_handle[6];
  LC_ID lc_id[6];
  struct {
    char *locale;
    wchar_t *wlocale;
    int *refcount;
    int *wrefcount;
  } lc_category[6];
  int lc_clike;
  int mb_cur_max;
  int *lconv_intl_refcount;
  int *lconv_num_refcount;
  int *lconv_mon_refcount;
  struct lconv *lconv;
  int *ctype1_refcount;
  unsigned short *ctype1;
  const unsigned short *pctype;
  const unsigned char *pclmap;
  const unsigned char *pcumap;
  struct __lc_time_data *lc_time_curr;

} threadlocinfo;
# 508 "C:/msys64/mingw64/include/corecrt.h" 3
#pragma pack(pop)
# 11 "C:/msys64/mingw64/include/corecrt_stdio_config.h" 2 3





unsigned long long* __attribute__((__cdecl__)) __local_stdio_printf_options(void);
unsigned long long* __attribute__((__cdecl__)) __local_stdio_scanf_options(void);
# 10 "C:/msys64/mingw64/include/stdio.h" 2 3

#pragma pack(push,_CRT_PACKING)

       

       

       

       
# 33 "C:/msys64/mingw64/include/stdio.h" 3
  struct _iobuf {



    char *_ptr;
    int _cnt;
    char *_base;
    int _flag;
    int _file;
    int _charbuf;
    int _bufsiz;
    char *_tmpfname;

  };
  typedef struct _iobuf FILE;
# 99 "C:/msys64/mingw64/include/stdio.h" 3
# 1 "C:/msys64/mingw64/include/_mingw_off_t.h" 1 3




  typedef long _off_t;

  typedef long off32_t;





  __extension__ typedef long long _off64_t;

  __extension__ typedef long long off64_t;
# 26 "C:/msys64/mingw64/include/_mingw_off_t.h" 3
typedef off32_t off_t;
# 100 "C:/msys64/mingw64/include/stdio.h" 2 3

__attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) __acrt_iob_func(unsigned index);

  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) __iob_func(void);
# 112 "C:/msys64/mingw64/include/stdio.h" 3
  __extension__ typedef long long fpos_t;
# 156 "C:/msys64/mingw64/include/stdio.h" 3
extern
  __attribute__((__format__(__gnu_scanf__, 2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_sscanf(const char * __restrict__ _Src,const char * __restrict__ _Format,...);
extern
  __attribute__((__format__(__gnu_scanf__, 2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vsscanf (const char * __restrict__ _Str,const char * __restrict__ Format,va_list argp);
extern
  __attribute__((__format__(__gnu_scanf__, 1,2))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_scanf(const char * __restrict__ _Format,...);
extern
  __attribute__((__format__(__gnu_scanf__, 1,0))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vscanf(const char * __restrict__ Format, va_list argp);
extern
  __attribute__((__format__(__gnu_scanf__, 2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fscanf(FILE * __restrict__ _File,const char * __restrict__ _Format,...);
extern
  __attribute__((__format__(__gnu_scanf__, 2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfscanf (FILE * __restrict__ fp, const char * __restrict__ Format,va_list argp);

extern
  __attribute__((__format__(__gnu_printf__,3,0))) __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_vsnprintf(char * __restrict__ _DstBuf,size_t _MaxCount,const char * __restrict__ _Format,
                               va_list _ArgList);
extern
  __attribute__((__format__(__gnu_printf__,3,4))) __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_snprintf(char * __restrict__ s, size_t n, const char * __restrict__ format, ...);
extern
  __attribute__((__format__(__gnu_printf__,1,2))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_printf(const char * __restrict__ , ... ) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,1,0))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vprintf (const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fprintf (FILE * __restrict__ , const char * __restrict__ , ...) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfprintf (FILE * __restrict__ , const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_sprintf (char * __restrict__ , const char * __restrict__ , ...) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vsprintf (char * __restrict__ , const char * __restrict__ , va_list) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,2,3))) __attribute__((nonnull (1,2)))
  int __attribute__((__cdecl__)) __mingw_asprintf(char ** __restrict__ , const char * __restrict__ , ...) __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__gnu_printf__,2,0))) __attribute__((nonnull (1,2)))
  int __attribute__((__cdecl__)) __mingw_vasprintf(char ** __restrict__ , const char * __restrict__ , va_list) __attribute__ ((__nothrow__));

extern
  __attribute__((__format__(__ms_scanf__, 2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_sscanf(const char * __restrict__ _Src,const char * __restrict__ _Format,...)
  ;
extern
  __attribute__((__format__(__ms_scanf__, 2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vsscanf(const char * __restrict__ _Str,const char * __restrict__ _Format,va_list argp)
  __asm__("vsscanf");
extern
  __attribute__((__format__(__ms_scanf__, 1,2))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_scanf(const char * __restrict__ _Format,...)
  ;
extern
  __attribute__((__format__(__ms_scanf__, 1,0))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_vscanf(const char * __restrict__ _Format,va_list argp)
  __asm__("vscanf");
extern
  __attribute__((__format__(__ms_scanf__, 2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_fscanf(FILE * __restrict__ _File,const char * __restrict__ _Format,...)
  ;
extern
  __attribute__((__format__(__ms_scanf__, 2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vfscanf(FILE * __restrict__ _File,const char * __restrict__ _Format,va_list argp)
  __asm__("vfscanf");

extern
  __attribute__((__format__(__ms_printf__, 1,2))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_printf(const char * __restrict__ , ... )
  __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__ms_printf__, 1,0))) __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_vprintf (const char * __restrict__ , va_list)
  __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__ms_printf__, 2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_fprintf (FILE * __restrict__ , const char * __restrict__ , ...)
  __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__ms_printf__, 2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vfprintf (FILE * __restrict__ , const char * __restrict__ , va_list)
  __attribute__ ((__nothrow__))
;
extern
  __attribute__((__format__(__ms_printf__, 2,3))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_sprintf (char * __restrict__ , const char * __restrict__ , ...)
  __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__ms_printf__, 2,0))) __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vsprintf (char * __restrict__ , const char * __restrict__ , va_list)
  __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__ms_printf__, 3,4))) __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __ms_snprintf (char * __restrict__ , size_t , const char * __restrict__ , ...)
  __attribute__ ((__nothrow__));
extern
  __attribute__((__format__(__ms_printf__, 3,0))) __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __ms_vsnprintf (char * __restrict__ , size_t , const char * __restrict__ , va_list)
  __attribute__ ((__nothrow__));
# 308 "C:/msys64/mingw64/include/stdio.h" 3
__attribute__((__format__(__gnu_scanf__, 2,3))) __attribute__ ((__nonnull__ (2)))
int sscanf(const char *__source, const char *__format, ...)
__asm__("__mingw_sscanf");

__attribute__((__format__(__gnu_scanf__, 1,2))) __attribute__ ((__nonnull__ (1)))
int scanf(const char *__format, ...)
__asm__("__mingw_scanf");

__attribute__((__format__(__gnu_scanf__, 2,3))) __attribute__ ((__nonnull__ (2)))
int fscanf(FILE *__stream, const char *__format, ...)
__asm__("__mingw_fscanf");



#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wshadow"


__attribute__((__format__(__gnu_scanf__, 2,0))) __attribute__ ((__nonnull__ (2)))
int vsscanf (const char *__source, const char *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vsscanf");

__attribute__((__format__(__gnu_scanf__, 1,0))) __attribute__ ((__nonnull__ (1)))
int vscanf(const char *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vscanf");

__attribute__((__format__(__gnu_scanf__, 2,0))) __attribute__ ((__nonnull__ (2)))
int vfscanf (FILE *__stream, const char *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vfscanf");


#pragma GCC diagnostic pop





__attribute__((__format__(__gnu_printf__,2,3))) __attribute__ ((__nonnull__ (2)))
int fprintf (FILE *__stream, const char *__format, ...)
__asm__("__mingw_fprintf");

__attribute__((__format__(__gnu_printf__,1,2))) __attribute__ ((__nonnull__ (1)))
int printf (const char *__format, ...)
__asm__("__mingw_printf");

__attribute__((__format__(__gnu_printf__,2,3))) __attribute__ ((__nonnull__ (2)))
int sprintf (char *__stream, const char *__format, ...)
__asm__("__mingw_sprintf");
# 374 "C:/msys64/mingw64/include/stdio.h" 3
__attribute__((__format__(__gnu_printf__,2,0))) __attribute__ ((__nonnull__ (2)))
int vfprintf (FILE *__stream, const char *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vfprintf");

__attribute__((__format__(__gnu_printf__,1,0))) __attribute__ ((__nonnull__ (1)))
int vprintf (const char *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vprintf");

static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__(__gnu_printf__,2,0))) __attribute__ ((__nonnull__ (2)))
int vsprintf (char *__stream, const char *__format, __builtin_va_list __local_argv)
{
# 394 "C:/msys64/mingw64/include/stdio.h" 3
  return __mingw_vsprintf( __stream, __format, __local_argv );
}


__attribute__((__format__(__gnu_printf__,3,4))) __attribute__ ((__nonnull__ (3)))
int snprintf (char *__stream, size_t __n, const char *__format, ...)
__asm__("__mingw_snprintf");
# 414 "C:/msys64/mingw64/include/stdio.h" 3
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
__attribute__((__format__(__gnu_printf__,3,0))) __attribute__ ((__nonnull__ (3)))
int vsnprintf (char *__stream, size_t __n, const char *__format, __builtin_va_list __local_argv)
{



  return __mingw_vsnprintf( __stream, __n, __format, __local_argv );
}
# 535 "C:/msys64/mingw64/include/stdio.h" 3
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _filbuf(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _flsbuf(int _Ch,FILE *_File);



  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _fsopen(const char *_Filename,const char *_Mode,int _ShFlag);

  void __attribute__((__cdecl__)) clearerr(FILE *_File);
  int __attribute__((__cdecl__)) fclose(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fcloseall(void);



  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _fdopen(int _FileHandle,const char *_Mode);

  int __attribute__((__cdecl__)) feof(FILE *_File);
  int __attribute__((__cdecl__)) ferror(FILE *_File);
  int __attribute__((__cdecl__)) fflush(FILE *_File);
  int __attribute__((__cdecl__)) fgetc(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fgetchar(void);
  int __attribute__((__cdecl__)) fgetpos(FILE * __restrict__ _File ,fpos_t * __restrict__ _Pos);
  int __attribute__((__cdecl__)) fgetpos64(FILE * __restrict__ _File ,fpos_t * __restrict__ _Pos);
  char *__attribute__((__cdecl__)) fgets(char * __restrict__ _Buf,int _MaxCount,FILE * __restrict__ _File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fileno(FILE *_File);







  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _tempnam(const char *_DirName,const char *_FilePrefix);



  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _flushall(void);
  FILE *__attribute__((__cdecl__)) fopen(const char * __restrict__ _Filename,const char * __restrict__ _Mode) ;
  FILE *__attribute__((__cdecl__)) fopen64(const char * __restrict__ filename,const char * __restrict__ mode);
  int __attribute__((__cdecl__)) fputc(int _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fputchar(int _Ch);
  int __attribute__((__cdecl__)) fputs(const char * __restrict__ _Str,FILE * __restrict__ _File);
  size_t __attribute__((__cdecl__)) fread(void * __restrict__ _DstBuf,size_t _ElementSize,size_t _Count,FILE * __restrict__ _File);
  FILE *__attribute__((__cdecl__)) freopen(const char * __restrict__ _Filename,const char * __restrict__ _Mode,FILE * __restrict__ _File) ;
  FILE *__attribute__((__cdecl__)) freopen64(const char * __restrict__ _Filename,const char * __restrict__ _Mode,FILE * __restrict__ _File);
  int __attribute__((__cdecl__)) fsetpos(FILE *_File,const fpos_t *_Pos);
  int __attribute__((__cdecl__)) fsetpos64(FILE *_File,const fpos_t *_Pos);
  int __attribute__((__cdecl__)) fseek(FILE *_File,long _Offset,int _Origin);
  long __attribute__((__cdecl__)) ftell(FILE *_File);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fseeki64(FILE *_File,long long _Offset,int _Origin);
  __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _ftelli64(FILE *_File);
  int __attribute__((__cdecl__)) fseeko(FILE *_File, off_t _Offset, int _Origin)



  ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) fseeko64(FILE *_File, _off64_t _Offset, int _Origin);
  off_t __attribute__((__cdecl__)) ftello(FILE *_File)



  ;
  __attribute__ ((__dllimport__)) _off64_t __attribute__((__cdecl__)) ftello64(FILE *_File);

  size_t __attribute__((__cdecl__)) fwrite(const void * __restrict__ _Str,size_t _Size,size_t _Count,FILE * __restrict__ _File);
  int __attribute__((__cdecl__)) getc(FILE *_File);
  int __attribute__((__cdecl__)) getchar(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _getmaxstdio(void);
  char *__attribute__((__cdecl__)) gets(char *_Buffer)

    __attribute__((__warning__("Using gets() is always unsafe - use fgets() instead")))

;
  int __attribute__((__cdecl__)) _getw(FILE *_File);


  void __attribute__((__cdecl__)) perror(const char *_ErrMsg);


  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _pclose(FILE *_File);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _popen(const char *_Command,const char *_Mode);





  int __attribute__((__cdecl__)) putc(int _Ch,FILE *_File);
  int __attribute__((__cdecl__)) putchar(int _Ch);
  int __attribute__((__cdecl__)) puts(const char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _putw(int _Word,FILE *_File);


  int __attribute__((__cdecl__)) remove(const char *_Filename);
  int __attribute__((__cdecl__)) rename(const char *_OldFilename,const char *_NewFilename);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _unlink(const char *_Filename);

  int __attribute__((__cdecl__)) unlink(const char *_Filename) ;


  void __attribute__((__cdecl__)) rewind(FILE *_File);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _rmtmp(void);
  void __attribute__((__cdecl__)) setbuf(FILE * __restrict__ _File,char * __restrict__ _Buffer) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _setmaxstdio(int _Max);
  __attribute__ ((__dllimport__)) unsigned int __attribute__((__cdecl__)) _set_output_format(unsigned int _Format);
  __attribute__ ((__dllimport__)) unsigned int __attribute__((__cdecl__)) _get_output_format(void);
  int __attribute__((__cdecl__)) setvbuf(FILE * __restrict__ _File,char * __restrict__ _Buf,int _Mode,size_t _Size);







  __attribute__ ((__pure__))
  __attribute__((__format__(__ms_printf__, 1,2))) __attribute__ ((__nonnull__ (1)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf(const char * __restrict__ _Format,...);
  __attribute__((__format__(__ms_scanf__, 3,4))) __attribute__ ((__nonnull__ (3)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf(const char * __restrict__ _Src,size_t _MaxCount,const char * __restrict__ _Format,...) ;

  __attribute__ ((__pure__))
  __attribute__((__format__(__ms_printf__, 1,0))) __attribute__ ((__nonnull__ (1)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscprintf(const char * __restrict__ _Format,va_list _ArgList);
  FILE *__attribute__((__cdecl__)) tmpfile(void) ;
  FILE *__attribute__((__cdecl__)) tmpfile64(void);
  char *__attribute__((__cdecl__)) tmpnam(char *_Buffer);
  int __attribute__((__cdecl__)) ungetc(int _Ch,FILE *_File);







  __attribute__((__format__(__ms_printf__, 3,4))) __attribute__ ((__nonnull__ (3)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf(char * __restrict__ _Dest,size_t _Count,const char * __restrict__ _Format,...) ;
  __attribute__((__format__(__ms_printf__, 3,0))) __attribute__ ((__nonnull__ (3)))
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf(char * __restrict__ _Dest,size_t _Count,const char * __restrict__ _Format,va_list _Args) ;
# 886 "C:/msys64/mingw64/include/stdio.h" 3
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _set_printf_count_output(int _Value);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _get_printf_count_output(void);




                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_swscanf(const wchar_t * __restrict__ _Src,const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vswscanf (const wchar_t * __restrict__ _Str,const wchar_t * __restrict__ Format,va_list argp);
                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_wscanf(const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vwscanf(const wchar_t * __restrict__ Format, va_list argp);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fwscanf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfwscanf (FILE * __restrict__ fp, const wchar_t * __restrict__ Format,va_list argp);

                                                      __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_fwprintf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...);
                                                      __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_wprintf(const wchar_t * __restrict__ _Format,...);
                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __mingw_vfwprintf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,va_list _ArgList);
                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __mingw_vwprintf(const wchar_t * __restrict__ _Format,va_list _ArgList);
                                                      __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_snwprintf (wchar_t * __restrict__ s, size_t n, const wchar_t * __restrict__ format, ...);
                                                      __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_vsnwprintf (wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ , va_list);
                                                      __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_swprintf(wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ , ...);
                                                      __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __mingw_vswprintf(wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ ,va_list);

                                                    __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_swscanf(const wchar_t * __restrict__ _Src,const wchar_t * __restrict__ _Format,...)
  ;
                                                    __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vswscanf(const wchar_t * __restrict__ _Src,const wchar_t * __restrict__ _Format,va_list)
  __asm__("vswscanf");
                                                    __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_wscanf(const wchar_t * __restrict__ _Format,...)
  ;
                                                    __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_vwscanf(const wchar_t * __restrict__ _Format, va_list)
  __asm__("vwscanf");
                                                    __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_fwscanf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...)
  ;
                                                    __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vfwscanf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,va_list)
  __asm__("vfwscanf");

                                                     __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_fwprintf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,...);


                                                     __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_wprintf(const wchar_t * __restrict__ _Format,...)
  ;
                                                    __attribute__ ((__nonnull__ (2)))
  int __attribute__((__cdecl__)) __ms_vfwprintf(FILE * __restrict__ _File,const wchar_t * __restrict__ _Format,va_list _ArgList)
  ;
                                                    __attribute__ ((__nonnull__ (1)))
  int __attribute__((__cdecl__)) __ms_vwprintf(const wchar_t * __restrict__ _Format,va_list _ArgList)
  ;
                                                     __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __ms_swprintf(wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ , ...)
  ;
                                                     __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __ms_vswprintf(wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ ,va_list)
  ;
                                                     __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __ms_snwprintf(wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ , ...)
  ;
                                                     __attribute__ ((__nonnull__ (3)))
  int __attribute__((__cdecl__)) __ms_vsnwprintf(wchar_t * __restrict__ , size_t, const wchar_t * __restrict__ , va_list)
  ;
# 979 "C:/msys64/mingw64/include/stdio.h" 3
                                                     __attribute__ ((__nonnull__ (2)))
int swscanf(const wchar_t *__source, const wchar_t *__format, ...)
__asm__("__mingw_swscanf");

                                                     __attribute__ ((__nonnull__ (1)))
int wscanf(const wchar_t *__format, ...)
__asm__("__mingw_wscanf");

                                                     __attribute__ ((__nonnull__ (2)))
int fwscanf(FILE *__stream, const wchar_t *__format, ...)
__asm__("__mingw_fwscanf");


                                                     __attribute__ ((__nonnull__ (2)))
int vswscanf (const wchar_t * __restrict__ __source, const wchar_t * __restrict__ __format, __builtin_va_list __local_argv)
__asm__("__mingw_vswscanf");

                                                     __attribute__ ((__nonnull__ (1)))
int vwscanf(const wchar_t *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vwscanf");

                                                     __attribute__ ((__nonnull__ (2)))
int vfwscanf (FILE *__stream, const wchar_t *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vfwscanf");




                                                      __attribute__ ((__nonnull__ (2)))
int fwprintf (FILE *__stream, const wchar_t *__format, ...)
__asm__("__mingw_fwprintf");

                                                      __attribute__ ((__nonnull__ (1)))
int wprintf (const wchar_t *__format, ...)
__asm__("__mingw_wprintf");

                                                      __attribute__ ((__nonnull__ (2)))
int vfwprintf (FILE *__stream, const wchar_t *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vfwprintf");

                                                      __attribute__ ((__nonnull__ (1)))
int vwprintf (const wchar_t *__format, __builtin_va_list __local_argv)
__asm__("__mingw_vwprintf");

                                                      __attribute__ ((__nonnull__ (3)))
int swprintf (wchar_t *__stream, size_t __n, const wchar_t *__format, ...)
__asm__("__mingw_swprintf");
# 1039 "C:/msys64/mingw64/include/stdio.h" 3
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (3)))
int vswprintf (wchar_t *__stream, size_t __n, const wchar_t *__format, __builtin_va_list __local_argv)
{



  return __mingw_vswprintf( __stream, __n, __format, __local_argv );
}



                                                      __attribute__ ((__nonnull__ (3)))
int snwprintf (wchar_t *__stream, size_t __n, const wchar_t *__format, ...)
__asm__("__mingw_snwprintf");
# 1067 "C:/msys64/mingw64/include/stdio.h" 3
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
                                                      __attribute__ ((__nonnull__ (3)))
int vsnwprintf (wchar_t *__stream, size_t __n, const wchar_t *__format, __builtin_va_list __local_argv)
{



  return __mingw_vsnwprintf( __stream, __n, __format, __local_argv );
}
# 1116 "C:/msys64/mingw64/include/stdio.h" 3
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfsopen(const wchar_t *_Filename,const wchar_t *_Mode,int _ShFlag);


  wint_t __attribute__((__cdecl__)) fgetwc(FILE *_File);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _fgetwchar(void);
  wint_t __attribute__((__cdecl__)) fputwc(wchar_t _Ch,FILE *_File);
  __attribute__ ((__dllimport__)) wint_t __attribute__((__cdecl__)) _fputwchar(wchar_t _Ch);
  wint_t __attribute__((__cdecl__)) getwc(FILE *_File);
  wint_t __attribute__((__cdecl__)) getwchar(void);
  wint_t __attribute__((__cdecl__)) putwc(wchar_t _Ch,FILE *_File);
  wint_t __attribute__((__cdecl__)) putwchar(wchar_t _Ch);
  wint_t __attribute__((__cdecl__)) ungetwc(wint_t _Ch,FILE *_File);
  wchar_t *__attribute__((__cdecl__)) fgetws(wchar_t * __restrict__ _Dst,int _SizeInWords,FILE * __restrict__ _File);
  int __attribute__((__cdecl__)) fputws(const wchar_t * __restrict__ _Str,FILE * __restrict__ _File);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _getws(wchar_t *_String) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _putws(const wchar_t *_Str);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf(const wchar_t * __restrict__ _Format,...);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_c(wchar_t * __restrict__ _DstBuf,size_t _SizeInWords,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_c(wchar_t * __restrict__ _DstBuf,size_t _SizeInWords,const wchar_t * __restrict__ _Format,va_list _ArgList);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf(wchar_t * __restrict__ _Dest,size_t _Count,const wchar_t * __restrict__ _Format,...) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf(wchar_t * __restrict__ _Dest,size_t _Count,const wchar_t * __restrict__ _Format,va_list _Args) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscwprintf(const wchar_t * __restrict__ _Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf(wchar_t * __restrict__ _Dest,const wchar_t * __restrict__ _Format,va_list _Args);


# 1 "C:/msys64/mingw64/include/swprintf.inl" 1 3
# 1146 "C:/msys64/mingw64/include/stdio.h" 2 3
# 1159 "C:/msys64/mingw64/include/stdio.h" 3
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wtempnam(const wchar_t *_Directory,const wchar_t *_FilePrefix);



  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf(const wchar_t * __restrict__ _Src,size_t _MaxCount,const wchar_t * __restrict__ _Format,...);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfdopen(int _FileHandle ,const wchar_t *_Mode);
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfopen(const wchar_t * __restrict__ _Filename,const wchar_t *__restrict__ _Mode) ;
  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wfreopen(const wchar_t * __restrict__ _Filename,const wchar_t * __restrict__ _Mode,FILE * __restrict__ _OldFile) ;



  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wperror(const wchar_t *_ErrMsg);

  __attribute__ ((__dllimport__)) FILE *__attribute__((__cdecl__)) _wpopen(const wchar_t *_Command,const wchar_t *_Mode);




  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wremove(const wchar_t *_Filename);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wtmpnam(wchar_t *_Buffer);
# 1222 "C:/msys64/mingw64/include/stdio.h" 3
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _lock_file(FILE *_File);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _unlock_file(FILE *_File);
# 1244 "C:/msys64/mingw64/include/stdio.h" 3
  char *__attribute__((__cdecl__)) tempnam(const char *_Directory,const char *_FilePrefix) ;



  int __attribute__((__cdecl__)) fcloseall(void) ;
  FILE *__attribute__((__cdecl__)) fdopen(int _FileHandle,const char *_Format) ;
  int __attribute__((__cdecl__)) fgetchar(void) ;
  int __attribute__((__cdecl__)) fileno(FILE *_File) ;
  int __attribute__((__cdecl__)) flushall(void) ;
  int __attribute__((__cdecl__)) fputchar(int _Ch) ;
  int __attribute__((__cdecl__)) getw(FILE *_File) ;
  int __attribute__((__cdecl__)) putw(int _Ch,FILE *_File) ;
  int __attribute__((__cdecl__)) rmtmp(void) ;
# 1273 "C:/msys64/mingw64/include/stdio.h" 3
int __attribute__((__cdecl__)) __mingw_str_wide_utf8 (const wchar_t * const wptr, char **mbptr, size_t * buflen);
# 1287 "C:/msys64/mingw64/include/stdio.h" 3
int __attribute__((__cdecl__)) __mingw_str_utf8_wide (const char *const mbptr, wchar_t ** wptr, size_t * buflen);
# 1296 "C:/msys64/mingw64/include/stdio.h" 3
void __attribute__((__cdecl__)) __mingw_str_free(void *ptr);






  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnl(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnle(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnlp(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnlpe(int _Mode,const wchar_t *_Filename,const wchar_t *_ArgList,...);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnv(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnve(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList,const wchar_t *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnvp(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _wspawnvpe(int _Mode,const wchar_t *_Filename,const wchar_t *const *_ArgList,const wchar_t *const *_Env);
# 1327 "C:/msys64/mingw64/include/stdio.h" 3
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnv(int _Mode,const char *_Filename,const char *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnve(int _Mode,const char *_Filename,const char *const *_ArgList,const char *const *_Env);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnvp(int _Mode,const char *_Filename,const char *const *_ArgList);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _spawnvpe(int _Mode,const char *_Filename,const char *const *_ArgList,const char *const *_Env);







       
       
       
       

#pragma pack(pop)

# 1 "C:/msys64/mingw64/include/sec_api/stdio_s.h" 1 3
# 9 "C:/msys64/mingw64/include/sec_api/stdio_s.h" 3
# 1 "C:/msys64/mingw64/include/stdio.h" 1 3
# 10 "C:/msys64/mingw64/include/sec_api/stdio_s.h" 2 3
# 29 "C:/msys64/mingw64/include/sec_api/stdio_s.h" 3
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) clearerr_s(FILE *_File);

  size_t __attribute__((__cdecl__)) fread_s(void *_DstBuf,size_t _DstSize,size_t _ElementSize,size_t _Count,FILE *_File);
# 515 "C:/msys64/mingw64/include/sec_api/stdio_s.h" 3
  int __attribute__((__cdecl__)) fprintf_s(FILE *_File,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fscanf_s_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) fscanf_s(FILE *_File, const char *_Format, ...);
  int __attribute__((__cdecl__)) printf_s(const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scanf_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scanf_s_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) scanf_s(const char *_Format, ...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_c(char *_DstBuf,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_c(char *_DstBuf,size_t _MaxCount,const char *_Format,va_list _ArgList);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fscanf_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sscanf_l(const char *_Src,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sscanf_s_l(const char *_Src,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) sscanf_s(const char *_Src,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf_s(const char *_Src,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf_l(const char *_Src,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snscanf_s_l(const char *_Src,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  int __attribute__((__cdecl__)) vfprintf_s(FILE *_File,const char *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) vprintf_s(const char *_Format,va_list _ArgList);

  int __attribute__((__cdecl__)) vsnprintf_s(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,va_list _ArgList);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_s(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,va_list _ArgList);

  __attribute__((dllimport)) int __attribute__((__cdecl__)) vsprintf_s(char *_DstBuf,size_t _Size,const char *_Format,va_list _ArgList);

  __attribute__((dllimport)) int __attribute__((__cdecl__)) sprintf_s(char *_DstBuf,size_t _DstSize,const char *_Format,...);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_s(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,...);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_p(FILE *_File,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_p(const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_p(char *_Dst,size_t _MaxCount,const char *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_p(FILE *_File,const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_p(const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_p(char *_Dst,size_t _MaxCount,const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf_p(const char *_Format,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vscprintf_p(const char *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_p_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_p_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_p_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_l(FILE *_File,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_p_l(FILE *_File,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_l(char *_DstBuf,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_p_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_l(char *_DstBuf,const char *_Format,_locale_t,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_p_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scprintf_p_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscprintf_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscprintf_p_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _printf_s_l(const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vprintf_s_l(const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fprintf_s_l(FILE *_File,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfprintf_s_l(FILE *_File,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _sprintf_s_l(char *_DstBuf,size_t _DstSize,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsprintf_s_l(char *_DstBuf,size_t _DstSize,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_s_l(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_s_l(char *_DstBuf,size_t _DstSize,size_t _MaxCount,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snprintf_c_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_l(char *_DstBuf,size_t _MaxCount,const char *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnprintf_c_l(char *_DstBuf,size_t _MaxCount,const char *,_locale_t _Locale,va_list _ArgList);


 
 
 
 
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) fopen_s(FILE **_File,const char *_Filename,const char *_Mode);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) freopen_s(FILE** _File, const char *_Filename, const char *_Mode, FILE *_Stream);

  __attribute__ ((__dllimport__)) char* __attribute__((__cdecl__)) gets_s(char*,rsize_t);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) tmpfile_s(FILE **_File);

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) tmpnam_s(char*,rsize_t);
 




  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _getws_s(wchar_t *_Str,size_t _SizeInWords);
 
# 830 "C:/msys64/mingw64/include/sec_api/stdio_s.h" 3
  int __attribute__((__cdecl__)) fwprintf_s(FILE *_File,const wchar_t *_Format,...);
  int __attribute__((__cdecl__)) wprintf_s(const wchar_t *_Format,...);
  int __attribute__((__cdecl__)) vfwprintf_s(FILE *_File,const wchar_t *_Format,va_list _ArgList);
  int __attribute__((__cdecl__)) vwprintf_s(const wchar_t *_Format,va_list _ArgList);

  int __attribute__((__cdecl__)) vswprintf_s(wchar_t *_Dst,size_t _SizeInWords,const wchar_t *_Format,va_list _ArgList);

  int __attribute__((__cdecl__)) swprintf_s(wchar_t *_Dst,size_t _SizeInWords,const wchar_t *_Format,...);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf_s(wchar_t *_DstBuf,size_t _DstSizeInWords,size_t _MaxCount,const wchar_t *_Format,va_list _ArgList);

  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf_s(wchar_t *_DstBuf,size_t _DstSizeInWords,size_t _MaxCount,const wchar_t *_Format,...);


  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_s_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_s_l(const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_s_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_s_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf_s_l(wchar_t *_DstBuf,size_t _DstSize,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwscanf_s_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) fwscanf_s(FILE *_File, const wchar_t *_Format, ...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swscanf_s_l(const wchar_t *_Src,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) swscanf_s(const wchar_t *_Src,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf_s(const wchar_t *_Src,size_t _MaxCount,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf_s_l(const wchar_t *_Src,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wscanf_s_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) wscanf_s(const wchar_t *_Format, ...);


 
 
 
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wfopen_s(FILE **_File,const wchar_t *_Filename,const wchar_t *_Mode);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wfreopen_s(FILE **_File,const wchar_t *_Filename,const wchar_t *_Mode,FILE *_OldFile);

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wtmpnam_s(wchar_t *_DstBuf,size_t _SizeInWords);
 


  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_p(FILE *_File,const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_p(const wchar_t *_Format,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_p(FILE *_File,const wchar_t *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_p(const wchar_t *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_p(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vswprintf_p(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf_p(const wchar_t *_Format,...);
  __attribute__((dllimport)) int __attribute__((__cdecl__)) _vscwprintf_p(const wchar_t *_Format,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wprintf_p_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_l(const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vwprintf_p_l(const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwprintf_p_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vfwprintf_p_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_c_l(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swprintf_p_l(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_c_l(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vswprintf_p_l(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _scwprintf_p_l(const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscwprintf_p_l(const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwprintf_l(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vsnwprintf_l(wchar_t *_DstBuf,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __swprintf_l(wchar_t *_Dest,const wchar_t *_Format,_locale_t _Plocinfo,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) __vswprintf_l(wchar_t *_Dest,const wchar_t *_Format,_locale_t _Plocinfo,va_list _Args);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _vscwprintf_l(const wchar_t *_Format,_locale_t _Locale,va_list _ArgList);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fwscanf_l(FILE *_File,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _swscanf_l(const wchar_t *_Src,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _snwscanf_l(const wchar_t *_Src,size_t _MaxCount,const wchar_t *_Format,_locale_t _Locale,...);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wscanf_l(const wchar_t *_Format,_locale_t _Locale,...);
# 1346 "C:/msys64/mingw64/include/stdio.h" 2 3
# 2 "c/src/main.c" 2
# 1 "C:/msys64/mingw64/include/stdlib.h" 1 3
# 10 "C:/msys64/mingw64/include/stdlib.h" 3
# 1 "C:/msys64/mingw64/include/corecrt_wstdlib.h" 1 3
# 19 "C:/msys64/mingw64/include/corecrt_wstdlib.h" 3
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wdupenv_s(wchar_t **_Buffer,size_t *_BufferSizeInWords,const wchar_t *_VarName);




  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _itow_s (int _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ltow_s (long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ultow_s (unsigned long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wgetenv_s(size_t *_ReturnSize,wchar_t *_DstBuf,size_t _DstSizeInWords,const wchar_t *_VarName);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _i64tow_s(long long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ui64tow_s(unsigned long long _Val,wchar_t *_DstBuf,size_t _SizeInWords,int _Radix);

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wmakepath_s(wchar_t *_PathResult,size_t _SizeInWords,const wchar_t *_Drive,const wchar_t *_Dir,const wchar_t *_Filename,const wchar_t *_Ext);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wputenv_s(const wchar_t *_Name,const wchar_t *_Value);

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wsearchenv_s(const wchar_t *_Filename,const wchar_t *_EnvVar,wchar_t *_ResultPath,size_t _SizeInWords);
 

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wsplitpath_s(const wchar_t *_FullPath,wchar_t *_Drive,size_t _DriveSizeInWords,wchar_t *_Dir,size_t _DirSizeInWords,wchar_t *_Filename,size_t _FilenameSizeInWords,wchar_t *_Ext,size_t _ExtSizeInWords);
 
# 11 "C:/msys64/mingw64/include/stdlib.h" 2 3
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/limits.h" 1 3 4
# 34 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/limits.h" 3 4
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/syslimits.h" 1 3 4






 
# 7 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/syslimits.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/limits.h" 1 3 4
# 210 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/limits.h" 3 4
# 1 "C:/msys64/mingw64/include/limits.h" 1 3 4





# 1 "C:/msys64/mingw64/include/crtdefs.h" 1 3 4
# 7 "C:/msys64/mingw64/include/limits.h" 2 3 4
# 211 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/limits.h" 2 3 4
# 10 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/syslimits.h" 2 3 4
#pragma GCC diagnostic pop
# 35 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/limits.h" 2 3 4
# 12 "C:/msys64/mingw64/include/stdlib.h" 2 3
# 26 "C:/msys64/mingw64/include/stdlib.h" 3
#pragma pack(push,_CRT_PACKING)
# 50 "C:/msys64/mingw64/include/stdlib.h" 3
  typedef int (__attribute__((__cdecl__)) *_onexit_t)(void);
# 60 "C:/msys64/mingw64/include/stdlib.h" 3
  typedef struct _div_t {
    int quot;
    int rem;
  } div_t;

  typedef struct _ldiv_t {
    long quot;
    long rem;
  } ldiv_t;





#pragma pack(4)
  typedef struct {
    unsigned char ld[10];
  } _LDOUBLE;
#pragma pack()



  typedef struct {
    double x;
  } _CRT_DOUBLE;

  typedef struct {
    float f;
  } _CRT_FLOAT;

       


  typedef struct {
    long double x;
  } _LONGDOUBLE;

       

#pragma pack(4)
  typedef struct {
    unsigned char ld12[12];
  } _LDBL12;
#pragma pack()
# 113 "C:/msys64/mingw64/include/stdlib.h" 3
__attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) ___mb_cur_max_func(void);
# 135 "C:/msys64/mingw64/include/stdlib.h" 3
  typedef void (__attribute__((__cdecl__)) *_purecall_handler)(void);

  __attribute__ ((__dllimport__)) _purecall_handler __attribute__((__cdecl__)) _set_purecall_handler(_purecall_handler _Handler);
  __attribute__ ((__dllimport__)) _purecall_handler __attribute__((__cdecl__)) _get_purecall_handler(void);

  typedef void (__attribute__((__cdecl__)) *_invalid_parameter_handler)(const wchar_t *,const wchar_t *,const wchar_t *,unsigned int,uintptr_t);
  __attribute__ ((__dllimport__)) _invalid_parameter_handler __attribute__((__cdecl__)) _set_invalid_parameter_handler(_invalid_parameter_handler _Handler);
  __attribute__ ((__dllimport__)) _invalid_parameter_handler __attribute__((__cdecl__)) _get_invalid_parameter_handler(void);



  __attribute__ ((__dllimport__)) extern int *__attribute__((__cdecl__)) _errno(void);

  errno_t __attribute__((__cdecl__)) _set_errno(int _Value);
  errno_t __attribute__((__cdecl__)) _get_errno(int *_Value);

  __attribute__ ((__dllimport__)) unsigned long *__attribute__((__cdecl__)) __doserrno(void);

  errno_t __attribute__((__cdecl__)) _set_doserrno(unsigned long _Value);
  errno_t __attribute__((__cdecl__)) _get_doserrno(unsigned long *_Value);
  __attribute__ ((__dllimport__)) char **__attribute__((__cdecl__)) __sys_errlist(void);
  __attribute__ ((__dllimport__)) int *__attribute__((__cdecl__)) __sys_nerr(void);



  __attribute__ ((__dllimport__)) char ***__attribute__((__cdecl__)) __p___argv(void);
  __attribute__ ((__dllimport__)) int *__attribute__((__cdecl__)) __p__fmode(void);
  __attribute__ ((__dllimport__)) int *__attribute__((__cdecl__)) __p___argc(void);
  __attribute__ ((__dllimport__)) wchar_t ***__attribute__((__cdecl__)) __p___wargv(void);
  __attribute__ ((__dllimport__)) char **__attribute__((__cdecl__)) __p__pgmptr(void);
  __attribute__ ((__dllimport__)) wchar_t **__attribute__((__cdecl__)) __p__wpgmptr(void);

  errno_t __attribute__((__cdecl__)) _get_pgmptr(char **_Value);
  errno_t __attribute__((__cdecl__)) _get_wpgmptr(wchar_t **_Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _set_fmode(int _Mode);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _get_fmode(int *_PMode);
# 221 "C:/msys64/mingw64/include/stdlib.h" 3
  __attribute__ ((__dllimport__)) char ***__attribute__((__cdecl__)) __p__environ(void);
  __attribute__ ((__dllimport__)) wchar_t ***__attribute__((__cdecl__)) __p__wenviron(void);
# 234 "C:/msys64/mingw64/include/stdlib.h" 3
  __attribute__ ((__dllimport__)) unsigned int *__attribute__((__cdecl__)) __p__osplatform(void);
  __attribute__ ((__dllimport__)) unsigned int *__attribute__((__cdecl__)) __p__osver(void);
  __attribute__ ((__dllimport__)) unsigned int *__attribute__((__cdecl__)) __p__winver(void);
  __attribute__ ((__dllimport__)) unsigned int *__attribute__((__cdecl__)) __p__winmajor(void);
  __attribute__ ((__dllimport__)) unsigned int *__attribute__((__cdecl__)) __p__winminor(void);
# 256 "C:/msys64/mingw64/include/stdlib.h" 3
  errno_t __attribute__((__cdecl__)) _get_osplatform(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_osver(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_winver(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_winmajor(unsigned int *_Value);
  errno_t __attribute__((__cdecl__)) _get_winminor(unsigned int *_Value);
# 274 "C:/msys64/mingw64/include/stdlib.h" 3
  void __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) exit(int _Code) __attribute__ ((__noreturn__));
  void __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) _exit(int _Code) __attribute__ ((__noreturn__));






  void __attribute__((__cdecl__)) _Exit(int) __attribute__ ((__noreturn__));






       

  void __attribute__((__cdecl__)) __attribute__ ((__noreturn__)) abort(void);
       



  __attribute__ ((__dllimport__)) unsigned int __attribute__((__cdecl__)) _set_abort_behavior(unsigned int _Flags,unsigned int _Mask);



  int __attribute__((__cdecl__)) abs(int _X);
  long __attribute__((__cdecl__)) labs(long _X);


  __extension__ long long __attribute__((__cdecl__)) _abs64(long long);

  extern __inline__ __attribute__((__always_inline__,__gnu_inline__)) long long __attribute__((__cdecl__)) _abs64(long long x) {
    return __builtin_llabs(x);
  }


  int __attribute__((__cdecl__)) atexit(void (__attribute__((__cdecl__)) *)(void));





  double __attribute__((__cdecl__)) atof(const char *_String);
  double __attribute__((__cdecl__)) _atof_l(const char *_String,_locale_t _Locale);

  int __attribute__((__cdecl__)) atoi(const char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoi_l(const char *_Str,_locale_t _Locale);
  long __attribute__((__cdecl__)) atol(const char *_Str);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _atol_l(const char *_Str,_locale_t _Locale);


  void *__attribute__((__cdecl__)) bsearch(const void *_Key,const void *_Base,size_t _NumOfElements,size_t _SizeOfElements,int (__attribute__((__cdecl__)) *_PtFuncCompare)(const void *,const void *));
  void __attribute__((__cdecl__)) qsort(void *_Base,size_t _NumOfElements,size_t _SizeOfElements,int (__attribute__((__cdecl__)) *_PtFuncCompare)(const void *,const void *));

  unsigned short __attribute__((__cdecl__)) _byteswap_ushort(unsigned short _Short);
  unsigned long __attribute__((__cdecl__)) _byteswap_ulong (unsigned long _Long);
  __extension__ unsigned long long __attribute__((__cdecl__)) _byteswap_uint64(unsigned long long _Int64);
  div_t __attribute__((__cdecl__)) div(int _Numerator,int _Denominator);
  char *__attribute__((__cdecl__)) getenv(const char *_VarName) ;
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _itoa(int _Value,char *_Dest,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _i64toa(long long _Val,char *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ui64toa(unsigned long long _Val,char *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _atoi64(const char *_String);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _atoi64_l(const char *_String,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _strtoi64(const char *_String,char **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _strtoi64_l(const char *_String,char **_EndPtr,int _Radix,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _strtoui64(const char *_String,char **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _strtoui64_l(const char *_String,char **_EndPtr,int _Radix,_locale_t _Locale);
  ldiv_t __attribute__((__cdecl__)) ldiv(long _Numerator,long _Denominator);
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ltoa(long _Value,char *_Dest,int _Radix) ;
  int __attribute__((__cdecl__)) mblen(const char *_Ch,size_t _MaxCount);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _mblen_l(const char *_Ch,size_t _MaxCount,_locale_t _Locale);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstrlen(const char *_Str);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstrlen_l(const char *_Str,_locale_t _Locale);




  int __attribute__((__cdecl__)) mbtowc(wchar_t * __restrict__ _DstCh,const char * __restrict__ _SrcCh,size_t _SrcSizeInBytes);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _mbtowc_l(wchar_t * __restrict__ _DstCh,const char * __restrict__ _SrcCh,size_t _SrcSizeInBytes,_locale_t _Locale);
  size_t __attribute__((__cdecl__)) mbstowcs(wchar_t * __restrict__ _Dest,const char * __restrict__ _Source,size_t _MaxCount);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _mbstowcs_l(wchar_t * __restrict__ _Dest,const char * __restrict__ _Source,size_t _MaxCount,_locale_t _Locale);
  int __attribute__((__cdecl__)) mkstemp(char *template_name);
  int __attribute__((__cdecl__)) rand(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _set_error_mode(int _Mode);
  void __attribute__((__cdecl__)) srand(unsigned int _Seed);
# 371 "C:/msys64/mingw64/include/stdlib.h" 3
static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
double __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) strtod(const char * __restrict__ _Str,char ** __restrict__ _EndPtr)
{
  double __attribute__((__cdecl__)) __mingw_strtod (const char * __restrict__, char ** __restrict__);
  return __mingw_strtod( _Str, _EndPtr);
}

static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
float __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) strtof(const char * __restrict__ _Str,char ** __restrict__ _EndPtr)
{
  float __attribute__((__cdecl__)) __mingw_strtof (const char * __restrict__, char ** __restrict__);
  return __mingw_strtof( _Str, _EndPtr);
}






  long double __attribute__((__cdecl__)) __attribute__ ((__nothrow__)) strtold(const char * __restrict__ , char ** __restrict__ );


  extern double __attribute__((__cdecl__)) __attribute__ ((__nothrow__))
  __strtod (const char * __restrict__ , char ** __restrict__);







  float __attribute__((__cdecl__)) __mingw_strtof (const char * __restrict__, char ** __restrict__);
  double __attribute__((__cdecl__)) __mingw_strtod (const char * __restrict__, char ** __restrict__);
  long double __attribute__((__cdecl__)) __mingw_strtold(const char * __restrict__, char ** __restrict__);

  __attribute__ ((__dllimport__)) float __attribute__((__cdecl__)) _strtof_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,_locale_t _Locale);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _strtod_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,_locale_t _Locale);
  long __attribute__((__cdecl__)) strtol(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _strtol_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  unsigned long __attribute__((__cdecl__)) strtoul(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) unsigned long __attribute__((__cdecl__)) _strtoul_l(const char * __restrict__ _Str,char ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);


  int __attribute__((__cdecl__)) system(const char *_Command);

  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ultoa(unsigned long _Value,char *_Dest,int _Radix) ;
  int __attribute__((__cdecl__)) wctomb(char *_MbCh,wchar_t _WCh) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wctomb_l(char *_MbCh,wchar_t _WCh,_locale_t _Locale) ;
  size_t __attribute__((__cdecl__)) wcstombs(char * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _MaxCount) ;
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _wcstombs_l(char * __restrict__ _Dest,const wchar_t * __restrict__ _Source,size_t _MaxCount,_locale_t _Locale) ;
# 454 "C:/msys64/mingw64/include/stdlib.h" 3
  void *__attribute__((__cdecl__)) calloc(size_t _NumOfElements,size_t _SizeOfElements);
  void __attribute__((__cdecl__)) free(void *_Memory);
  void *__attribute__((__cdecl__)) malloc(size_t _Size);
  void *__attribute__((__cdecl__)) realloc(void *_Memory,size_t _NewSize);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _aligned_free(void *_Memory);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_malloc(size_t _Size,size_t _Alignment);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_offset_malloc(size_t _Size,size_t _Alignment,size_t _Offset);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_realloc(void *_Memory,size_t _Size,size_t _Alignment);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_offset_realloc(void *_Memory,size_t _Size,size_t _Alignment,size_t _Offset);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _recalloc(void *_Memory,size_t _Count,size_t _Size);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_recalloc(void *_Memory,size_t _Count,size_t _Size,size_t _Alignment);
  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _aligned_offset_recalloc(void *_Memory,size_t _Count,size_t _Size,size_t _Alignment,size_t _Offset);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _aligned_msize(void *_Memory,size_t _Alignment,size_t _Offset);


  size_t __attribute__((__cdecl__)) memalignment(const void *_Memory);
# 493 "C:/msys64/mingw64/include/stdlib.h" 3
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _itow(int _Value,wchar_t *_Dest,int _Radix) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _ltow(long _Value,wchar_t *_Dest,int _Radix) ;
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _ultow(unsigned long _Value,wchar_t *_Dest,int _Radix) ;

  double __attribute__((__cdecl__)) __mingw_wcstod(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr);
  float __attribute__((__cdecl__)) __mingw_wcstof(const wchar_t * __restrict__ nptr, wchar_t ** __restrict__ endptr);
  long double __attribute__((__cdecl__)) __mingw_wcstold(const wchar_t * __restrict__, wchar_t ** __restrict__);


  static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
  double __attribute__((__cdecl__)) wcstod(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr){
    return __mingw_wcstod(_Str,_EndPtr);
  }
  static __attribute__ ((__unused__)) __inline__ __attribute__((__cdecl__))
  float __attribute__((__cdecl__)) wcstof(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr){
    return __mingw_wcstof(_Str,_EndPtr);
  }






  long double __attribute__((__cdecl__)) wcstold(const wchar_t * __restrict__, wchar_t ** __restrict__);

  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _wcstod_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,_locale_t _Locale);
  __attribute__ ((__dllimport__)) float __attribute__((__cdecl__)) _wcstof_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,_locale_t _Locale);
  long __attribute__((__cdecl__)) wcstol(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _wcstol_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  unsigned long __attribute__((__cdecl__)) wcstoul(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix);
  __attribute__ ((__dllimport__)) unsigned long __attribute__((__cdecl__)) _wcstoul_l(const wchar_t * __restrict__ _Str,wchar_t ** __restrict__ _EndPtr,int _Radix,_locale_t _Locale);
  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wgetenv(const wchar_t *_VarName) ;


  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wsystem(const wchar_t *_Command);

  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _wtof(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _wtof_l(const wchar_t *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wtoi(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wtoi_l(const wchar_t *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _wtol(const wchar_t *_Str);
  __attribute__ ((__dllimport__)) long __attribute__((__cdecl__)) _wtol_l(const wchar_t *_Str,_locale_t _Locale);

  __extension__ __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _i64tow(long long _Val,wchar_t *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _ui64tow(unsigned long long _Val,wchar_t *_DstBuf,int _Radix) ;
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wtoi64(const wchar_t *_Str);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wtoi64_l(const wchar_t *_Str,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wcstoi64(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) long long __attribute__((__cdecl__)) _wcstoi64_l(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix,_locale_t _Locale);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _wcstoui64(const wchar_t *_Str,wchar_t **_EndPtr,int _Radix);
  __extension__ __attribute__ ((__dllimport__)) unsigned long long __attribute__((__cdecl__)) _wcstoui64_l(const wchar_t *_Str ,wchar_t **_EndPtr,int _Radix,_locale_t _Locale);


  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _putenv(const char *_EnvString);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _wputenv(const wchar_t *_EnvString);
# 556 "C:/msys64/mingw64/include/stdlib.h" 3
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _fullpath(char *_FullPath,const char *_Path,size_t _SizeInBytes);




  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _ecvt(double _Val,int _NumOfDigits,int *_PtDec,int *_PtSign) ;
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _fcvt(double _Val,int _NumOfDec,int *_PtDec,int *_PtSign) ;
  __attribute__ ((__dllimport__)) char *__attribute__((__cdecl__)) _gcvt(double _Val,int _NumOfDigits,char *_DstBuf) ;
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atodbl(_CRT_DOUBLE *_Result,char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoldbl(_LDOUBLE *_Result,char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoflt(_CRT_FLOAT *_Result,char *_Str);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atodbl_l(_CRT_DOUBLE *_Result,char *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoldbl_l(_LDOUBLE *_Result,char *_Str,_locale_t _Locale);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _atoflt_l(_CRT_FLOAT *_Result,char *_Str,_locale_t _Locale);
# 585 "C:/msys64/mingw64/include/stdlib.h" 3
unsigned long __attribute__((__cdecl__)) _lrotl(unsigned long,int);
unsigned long __attribute__((__cdecl__)) _lrotr(unsigned long,int);





  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _makepath(char *_Path,const char *_Drive,const char *_Dir,const char *_Filename,const char *_Ext);
  _onexit_t __attribute__((__cdecl__)) _onexit(_onexit_t _Func);





       
       


  __extension__ unsigned long long __attribute__((__cdecl__)) _rotl64(unsigned long long _Val,int _Shift);
  __extension__ unsigned long long __attribute__((__cdecl__)) _rotr64(unsigned long long Value,int Shift);
       
       
       
       


  unsigned int __attribute__((__cdecl__)) _rotr(unsigned int _Val,int _Shift);
  unsigned int __attribute__((__cdecl__)) _rotl(unsigned int _Val,int _Shift);
       
       
  __extension__ unsigned long long __attribute__((__cdecl__)) _rotr64(unsigned long long _Val,int _Shift);
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _searchenv(const char *_Filename,const char *_EnvVar,char *_ResultPath) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _splitpath(const char *_FullPath,char *_Drive,char *_Dir,char *_Filename,char *_Ext) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _swab(char *_Buf1,char *_Buf2,int _SizeInBytes);







  __attribute__ ((__dllimport__)) wchar_t *__attribute__((__cdecl__)) _wfullpath(wchar_t *_FullPath,const wchar_t *_Path,size_t _SizeInWords);



  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wmakepath(wchar_t *_ResultPath,const wchar_t *_Drive,const wchar_t *_Dir,const wchar_t *_Filename,const wchar_t *_Ext);




  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wsearchenv(const wchar_t *_Filename,const wchar_t *_EnvVar,wchar_t *_ResultPath) ;
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _wsplitpath(const wchar_t *_FullPath,wchar_t *_Drive,wchar_t *_Dir,wchar_t *_Filename,wchar_t *_Ext) ;


  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _beep(unsigned _Frequency,unsigned _Duration) __attribute__ ((__deprecated__));

  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _seterrormode(int _Mode) __attribute__ ((__deprecated__));
  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) _sleep(unsigned long _Duration) __attribute__ ((__deprecated__));
# 663 "C:/msys64/mingw64/include/stdlib.h" 3
  char *__attribute__((__cdecl__)) ecvt(double _Val,int _NumOfDigits,int *_PtDec,int *_PtSign) ;
  char *__attribute__((__cdecl__)) fcvt(double _Val,int _NumOfDec,int *_PtDec,int *_PtSign) ;
  char *__attribute__((__cdecl__)) gcvt(double _Val,int _NumOfDigits,char *_DstBuf) ;
  char *__attribute__((__cdecl__)) itoa(int _Val,char *_DstBuf,int _Radix) ;
  char *__attribute__((__cdecl__)) ltoa(long _Val,char *_DstBuf,int _Radix) ;
  int __attribute__((__cdecl__)) putenv(const char *_EnvString) ;



  void __attribute__((__cdecl__)) swab(char *_Buf1,char *_Buf2,int _SizeInBytes) ;


  char *__attribute__((__cdecl__)) ultoa(unsigned long _Val,char *_Dstbuf,int _Radix) ;
  _onexit_t __attribute__((__cdecl__)) onexit(_onexit_t _Func);





  typedef struct { __extension__ long long quot, rem; } lldiv_t;

  __extension__ lldiv_t __attribute__((__cdecl__)) lldiv(long long, long long);

  __extension__ long long __attribute__((__cdecl__)) llabs(long long);




  __extension__ long long __attribute__((__cdecl__)) strtoll(const char * __restrict__, char ** __restrict, int);
  __extension__ unsigned long long __attribute__((__cdecl__)) strtoull(const char * __restrict__, char ** __restrict__, int);


  __extension__ long long __attribute__((__cdecl__)) atoll (const char *);


  __extension__ long long __attribute__((__cdecl__)) wtoll (const wchar_t *);
  __extension__ char *__attribute__((__cdecl__)) lltoa (long long, char *, int);
  __extension__ char *__attribute__((__cdecl__)) ulltoa (unsigned long long , char *, int);
  __extension__ wchar_t *__attribute__((__cdecl__)) lltow (long long, wchar_t *, int);
  __extension__ wchar_t *__attribute__((__cdecl__)) ulltow (unsigned long long, wchar_t *, int);
# 720 "C:/msys64/mingw64/include/stdlib.h" 3
#pragma pack(pop)

# 1 "C:/msys64/mingw64/include/sec_api/stdlib_s.h" 1 3
# 9 "C:/msys64/mingw64/include/sec_api/stdlib_s.h" 3
# 1 "C:/msys64/mingw64/include/stdlib.h" 1 3
# 10 "C:/msys64/mingw64/include/sec_api/stdlib_s.h" 2 3
# 19 "C:/msys64/mingw64/include/sec_api/stdlib_s.h" 3
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _dupenv_s(char **_PBuffer,size_t *_PBufferSizeInBytes,const char *_VarName);




  __attribute__ ((__dllimport__)) void * __attribute__((__cdecl__)) bsearch_s(const void *_Key,const void *_Base,rsize_t _NumOfElements,rsize_t _SizeOfElements,int (__attribute__((__cdecl__)) * _PtFuncCompare)(void *, const void *, const void *), void *_Context);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) getenv_s(size_t *_ReturnSize,char *_DstBuf,rsize_t _DstSize,const char *_VarName);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _itoa_s(int _Value,char *_DstBuf,size_t _Size,int _Radix);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _i64toa_s(long long _Val,char *_DstBuf,size_t _Size,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ui64toa_s(unsigned long long _Val,char *_DstBuf,size_t _Size,int _Radix);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ltoa_s(long _Val,char *_DstBuf,size_t _Size,int _Radix);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) mbstowcs_s(size_t *_PtNumOfCharConverted,wchar_t *_DstBuf,size_t _SizeInWords,const char *_SrcBuf,size_t _MaxCount);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _mbstowcs_s_l(size_t *_PtNumOfCharConverted,wchar_t *_DstBuf,size_t _SizeInWords,const char *_SrcBuf,size_t _MaxCount,_locale_t _Locale);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ultoa_s(unsigned long _Val,char *_DstBuf,size_t _Size,int _Radix);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wctomb_s(int *_SizeConverted,char *_MbCh,rsize_t _SizeInBytes,wchar_t _WCh);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wctomb_s_l(int *_SizeConverted,char *_MbCh,size_t _SizeInBytes,wchar_t _WCh,_locale_t _Locale);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) wcstombs_s(size_t *_PtNumOfCharConverted,char *_Dst,size_t _DstSizeInBytes,const wchar_t *_Src,size_t _MaxCountInBytes);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _wcstombs_s_l(size_t *_PtNumOfCharConverted,char *_Dst,size_t _DstSizeInBytes,const wchar_t *_Src,size_t _MaxCountInBytes,_locale_t _Locale);
 


  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _ecvt_s(char *_DstBuf,size_t _Size,double _Val,int _NumOfDights,int *_PtDec,int *_PtSign);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _fcvt_s(char *_DstBuf,size_t _Size,double _Val,int _NumOfDec,int *_PtDec,int *_PtSign);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _gcvt_s(char *_DstBuf,size_t _Size,double _Val,int _NumOfDigits);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _makepath_s(char *_PathResult,size_t _Size,const char *_Drive,const char *_Dir,const char *_Filename,const char *_Ext);
 
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _putenv_s(const char *_Name,const char *_Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _searchenv_s(const char *_Filename,const char *_EnvVar,char *_ResultPath,size_t _SizeInBytes);

  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _splitpath_s(const char *_FullPath,char *_Drive,size_t _DriveSize,char *_Dir,size_t _DirSize,char *_Filename,size_t _FilenameSize,char *_Ext,size_t _ExtSize);
 



  __attribute__ ((__dllimport__)) void __attribute__((__cdecl__)) qsort_s(void *_Base,size_t _NumOfElements,size_t _SizeOfElements,int (__attribute__((__cdecl__)) *_PtFuncCompare)(void *,const void *,const void *),void *_Context);
# 723 "C:/msys64/mingw64/include/stdlib.h" 2 3
# 1 "C:/msys64/mingw64/include/malloc.h" 1 3
# 11 "C:/msys64/mingw64/include/malloc.h" 3
#pragma pack(push,_CRT_PACKING)
# 52 "C:/msys64/mingw64/include/malloc.h" 3
  typedef struct _heapinfo {
    int *_pentry;
    size_t _size;
    int _useflag;
  } _HEAPINFO;



  __attribute__ ((__dllimport__)) unsigned int *__attribute__((__cdecl__)) __p__amblksiz(void);
# 129 "C:/msys64/mingw64/include/malloc.h" 3
void * __mingw_aligned_malloc (size_t _Size, size_t _Alignment);
void __mingw_aligned_free (void *_Memory);
void * __mingw_aligned_offset_realloc (void *_Memory, size_t _Size, size_t _Alignment, size_t _Offset);
void * __mingw_aligned_offset_malloc (size_t, size_t, size_t);
void * __mingw_aligned_realloc (void *_Memory, size_t _Size, size_t _Offset);
size_t __mingw_aligned_msize (void *memblock, size_t alignment, size_t offset);



# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/mm_malloc.h" 1 3 4
# 29 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/mm_malloc.h" 3 4
# 1 "C:/msys64/mingw64/include/errno.h" 1 3 4
# 30 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/mm_malloc.h" 2 3 4


static __inline__ void *
_mm_malloc (size_t __size, size_t __align)
{
  void * __malloc_ptr;
  void * __aligned_ptr;


  if (__align & (__align - 1))
    {

      (*_errno()) = 22;

      return ((void *) 0);
    }

  if (__size == 0)
    return ((void *) 0);





    if (__align < 2 * sizeof (void *))
      __align = 2 * sizeof (void *);

  __malloc_ptr = malloc (__size + __align);
  if (!__malloc_ptr)
    return ((void *) 0);


  __aligned_ptr = (void *) (((size_t) __malloc_ptr + __align)
       & ~((size_t) (__align) - 1));


  ((void **) __aligned_ptr)[-1] = __malloc_ptr;

  return __aligned_ptr;
}

static __inline__ void
_mm_free (void *__aligned_ptr)
{
  if (__aligned_ptr)
    free (((void **) __aligned_ptr)[-1]);
}
# 139 "C:/msys64/mingw64/include/malloc.h" 2 3





  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _resetstkoflw (void);

  __attribute__ ((__dllimport__)) unsigned long __attribute__((__cdecl__)) _set_malloc_crt_max_wait(unsigned long _NewValue);







  __attribute__ ((__dllimport__)) void *__attribute__((__cdecl__)) _expand(void *_Memory,size_t _NewSize);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _msize(void *_Memory);
# 167 "C:/msys64/mingw64/include/malloc.h" 3
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _get_sbh_threshold(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _set_sbh_threshold(size_t _NewValue);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _set_amblksiz(size_t _Value);
  __attribute__ ((__dllimport__)) errno_t __attribute__((__cdecl__)) _get_amblksiz(size_t *_Value);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapadd(void *_Memory,size_t _Size);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapchk(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapmin(void);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapset(unsigned int _Fill);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _heapwalk(_HEAPINFO *_EntryInfo);
  __attribute__ ((__dllimport__)) size_t __attribute__((__cdecl__)) _heapused(size_t *_Used,size_t *_Commit);
  __attribute__ ((__dllimport__)) intptr_t __attribute__((__cdecl__)) _get_heap_handle(void);
# 190 "C:/msys64/mingw64/include/malloc.h" 3
  static __inline void *_MarkAllocaS(void *_Ptr,unsigned int _Marker) {
    if(_Ptr) {
      *((unsigned int*)_Ptr) = _Marker;
      _Ptr = (char*)_Ptr + 16;
    }
    return _Ptr;
  }
# 218 "C:/msys64/mingw64/include/malloc.h" 3
  static __inline void __attribute__((__cdecl__)) _freea(void *_Memory) {
    unsigned int _Marker;
    if(_Memory) {
      _Memory = (char*)_Memory - 16;
      _Marker = *(unsigned int *)_Memory;
      if(_Marker==0xDDDD) {
 free(_Memory);
      }





    }
  }
# 264 "C:/msys64/mingw64/include/malloc.h" 3
#pragma pack(pop)
# 724 "C:/msys64/mingw64/include/stdlib.h" 2 3
# 3 "c/src/main.c" 2
# 1 "C:/msys64/mingw64/include/math.h" 1 3
# 10 "C:/msys64/mingw64/include/math.h" 3
       
# 11 "C:/msys64/mingw64/include/math.h" 3




struct _exception;

#pragma pack(push,_CRT_PACKING)
# 117 "C:/msys64/mingw64/include/math.h" 3
  typedef union __mingw_dbl_type_t {
    double x;
    unsigned long long val;
    __extension__ struct {
      unsigned int low, high;
    } lh;
  } __mingw_dbl_type_t;

  typedef union __mingw_flt_type_t {
    float x;
    unsigned int val;
  } __mingw_flt_type_t;

  typedef union __mingw_ldbl_type_t
  {
    long double x;
    __extension__ struct {
      unsigned int low, high;
      int sign_exponent : 16;
      int res1 : 16;
      int res0 : 32;
    } lh;
  } __mingw_ldbl_type_t;




  extern double * __imp__HUGE;
# 156 "C:/msys64/mingw64/include/math.h" 3
  struct _exception {
    int type;
    const char *name;
    double arg1;
    double arg2;
    double retval;
  };

  void __mingw_raise_matherr (int typ, const char *name, double a1, double a2,
         double rslt);
  void __mingw_setusermatherr (int (__attribute__((__cdecl__)) *)(struct _exception *));
  __attribute__ ((__dllimport__)) void __setusermatherr(int (__attribute__((__cdecl__)) *)(struct _exception *));
# 182 "C:/msys64/mingw64/include/math.h" 3
  double __attribute__((__cdecl__)) sin(double _X);
  double __attribute__((__cdecl__)) cos(double _X);
  double __attribute__((__cdecl__)) tan(double _X);
  double __attribute__((__cdecl__)) sinh(double _X);
  double __attribute__((__cdecl__)) cosh(double _X);
  double __attribute__((__cdecl__)) tanh(double _X);
  double __attribute__((__cdecl__)) asin(double _X);
  double __attribute__((__cdecl__)) acos(double _X);
  double __attribute__((__cdecl__)) atan(double _X);
  double __attribute__((__cdecl__)) atan2(double _Y,double _X);
  double __attribute__((__cdecl__)) exp(double _X);
  double __attribute__((__cdecl__)) log(double _X);
  double __attribute__((__cdecl__)) log10(double _X);
  double __attribute__((__cdecl__)) pow(double _X,double _Y);
  double __attribute__((__cdecl__)) sqrt(double _X);
  double __attribute__((__cdecl__)) ceil(double _X);
  double __attribute__((__cdecl__)) floor(double _X);


  extern float __attribute__((__cdecl__)) fabsf (float x);
  extern long double __attribute__((__cdecl__)) fabsl (long double);
  extern double __attribute__((__cdecl__)) fabs (double _X);
# 242 "C:/msys64/mingw64/include/math.h" 3
  double __attribute__((__cdecl__)) ldexp(double _X,int _Y);
  double __attribute__((__cdecl__)) frexp(double _X,int *_Y);
  double __attribute__((__cdecl__)) modf(double _X,double *_Y);
  double __attribute__((__cdecl__)) fmod(double _X,double _Y);

  void __attribute__((__cdecl__)) sincos (double __x, double *p_sin, double *p_cos);
  void __attribute__((__cdecl__)) sincosl (long double __x, long double *p_sin, long double *p_cos);
  void __attribute__((__cdecl__)) sincosf (float __x, float *p_sin, float *p_cos);
# 267 "C:/msys64/mingw64/include/math.h" 3
  struct _complex {
    double x;
    double y;
  };


  double __attribute__((__cdecl__)) _cabs(struct _complex _ComplexA);
  double __attribute__((__cdecl__)) _hypot(double _X,double _Y);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _j0(double _X);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _j1(double _X);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _jn(int _X,double _Y);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _y0(double _X);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _y1(double _X);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _yn(int _X,double _Y);


  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _matherr (struct _exception *);
# 294 "C:/msys64/mingw64/include/math.h" 3
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _chgsign (double _X);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _copysign (double _Number,double _Sign);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _logb (double);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _nextafter (double, double);
  __attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) _scalb (double, long);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _finite (double);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fpclass (double);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isnan (double);






__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) j0 (double) ;
__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) j1 (double) ;
__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) jn (int, double) ;
__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) y0 (double) ;
__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) y1 (double) ;
__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) yn (int, double) ;



__attribute__ ((__dllimport__)) double __attribute__((__cdecl__)) chgsign (double);
# 326 "C:/msys64/mingw64/include/math.h" 3
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) finite (double);
  __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) fpclass (double);
# 370 "C:/msys64/mingw64/include/math.h" 3
typedef float float_t;
typedef double double_t;
# 405 "C:/msys64/mingw64/include/math.h" 3
  extern int __attribute__((__cdecl__)) __fpclassifyl (long double);
  extern int __attribute__((__cdecl__)) __fpclassifyf (float);
  extern int __attribute__((__cdecl__)) __fpclassify (double);
# 518 "C:/msys64/mingw64/include/math.h" 3
  extern int __attribute__((__cdecl__)) __isnan (double);
  extern int __attribute__((__cdecl__)) __isnanf (float);
  extern int __attribute__((__cdecl__)) __isnanl (long double);
# 605 "C:/msys64/mingw64/include/math.h" 3
  extern int __attribute__((__cdecl__)) __signbit (double);
  extern int __attribute__((__cdecl__)) __signbitf (float);
  extern int __attribute__((__cdecl__)) __signbitl (long double);
# 662 "C:/msys64/mingw64/include/math.h" 3
  extern float __attribute__((__cdecl__)) sinf(float _X);
  extern long double __attribute__((__cdecl__)) sinl(long double);

  extern float __attribute__((__cdecl__)) cosf(float _X);
  extern long double __attribute__((__cdecl__)) cosl(long double);

  extern float __attribute__((__cdecl__)) tanf(float _X);
  extern long double __attribute__((__cdecl__)) tanl(long double);
  extern float __attribute__((__cdecl__)) asinf(float _X);
  extern long double __attribute__((__cdecl__)) asinl(long double);

  extern float __attribute__((__cdecl__)) acosf (float);
  extern long double __attribute__((__cdecl__)) acosl (long double);

  extern float __attribute__((__cdecl__)) atanf (float);
  extern long double __attribute__((__cdecl__)) atanl (long double);

  extern float __attribute__((__cdecl__)) atan2f (float, float);
  extern long double __attribute__((__cdecl__)) atan2l (long double, long double);


  extern float __attribute__((__cdecl__)) sinhf(float _X);



  extern long double __attribute__((__cdecl__)) sinhl(long double);

  extern float __attribute__((__cdecl__)) coshf(float _X);



  extern long double __attribute__((__cdecl__)) coshl(long double);

  extern float __attribute__((__cdecl__)) tanhf(float _X);



  extern long double __attribute__((__cdecl__)) tanhl(long double);



  extern double __attribute__((__cdecl__)) acosh (double);
  extern float __attribute__((__cdecl__)) acoshf (float);
  extern long double __attribute__((__cdecl__)) acoshl (long double);


  extern double __attribute__((__cdecl__)) asinh (double);
  extern float __attribute__((__cdecl__)) asinhf (float);
  extern long double __attribute__((__cdecl__)) asinhl (long double);


  extern double __attribute__((__cdecl__)) atanh (double);
  extern float __attribute__((__cdecl__)) atanhf (float);
  extern long double __attribute__((__cdecl__)) atanhl (long double);



  extern float __attribute__((__cdecl__)) expf(float _X);



  extern long double __attribute__((__cdecl__)) expl(long double);


  extern double __attribute__((__cdecl__)) exp2(double);
  extern float __attribute__((__cdecl__)) exp2f(float);
  extern long double __attribute__((__cdecl__)) exp2l(long double);



  extern double __attribute__((__cdecl__)) expm1(double);
  extern float __attribute__((__cdecl__)) expm1f(float);
  extern long double __attribute__((__cdecl__)) expm1l(long double);


  extern float frexpf(float _X,int *_Y);



  extern long double __attribute__((__cdecl__)) frexpl(long double,int *);




  extern int __attribute__((__cdecl__)) ilogb (double);
  extern int __attribute__((__cdecl__)) ilogbf (float);
  extern int __attribute__((__cdecl__)) ilogbl (long double);


  extern float __attribute__((__cdecl__)) ldexpf(float _X,int _Y);



  extern long double __attribute__((__cdecl__)) ldexpl (long double, int);


  extern float __attribute__((__cdecl__)) logf (float);
  extern long double __attribute__((__cdecl__)) logl(long double);


  extern float __attribute__((__cdecl__)) log10f (float);
  extern long double __attribute__((__cdecl__)) log10l(long double);


  extern double __attribute__((__cdecl__)) log1p(double);
  extern float __attribute__((__cdecl__)) log1pf(float);
  extern long double __attribute__((__cdecl__)) log1pl(long double);


  extern double __attribute__((__cdecl__)) log2 (double);
  extern float __attribute__((__cdecl__)) log2f (float);
  extern long double __attribute__((__cdecl__)) log2l (long double);


  extern double __attribute__((__cdecl__)) logb (double);
  extern float __attribute__((__cdecl__)) logbf (float);
  extern long double __attribute__((__cdecl__)) logbl (long double);


  extern float __attribute__((__cdecl__)) modff (float, float*);
  extern long double __attribute__((__cdecl__)) modfl (long double, long double*);


  extern double __attribute__((__cdecl__)) scalbn (double, int);
  extern float __attribute__((__cdecl__)) scalbnf (float, int);
  extern long double __attribute__((__cdecl__)) scalbnl (long double, int);

  extern double __attribute__((__cdecl__)) scalbln (double, long);
  extern float __attribute__((__cdecl__)) scalblnf (float, long);
  extern long double __attribute__((__cdecl__)) scalblnl (long double, long);



  extern double __attribute__((__cdecl__)) cbrt (double);
  extern float __attribute__((__cdecl__)) cbrtf (float);
  extern long double __attribute__((__cdecl__)) cbrtl (long double);


  extern double __attribute__((__cdecl__)) hypot (double, double) ;
  extern float __attribute__((__cdecl__)) hypotf (float x, float y);



  extern long double __attribute__((__cdecl__)) hypotl (long double, long double);


  extern float __attribute__((__cdecl__)) powf(float _X,float _Y);



  extern long double __attribute__((__cdecl__)) powl (long double, long double);


  extern float __attribute__((__cdecl__)) sqrtf (float);
  extern long double sqrtl(long double);


  extern double __attribute__((__cdecl__)) erf (double);
  extern float __attribute__((__cdecl__)) erff (float);
  extern long double __attribute__((__cdecl__)) erfl (long double);


  extern double __attribute__((__cdecl__)) erfc (double);
  extern float __attribute__((__cdecl__)) erfcf (float);
  extern long double __attribute__((__cdecl__)) erfcl (long double);


  extern double __attribute__((__cdecl__)) lgamma (double);
  extern float __attribute__((__cdecl__)) lgammaf (float);
  extern long double __attribute__((__cdecl__)) lgammal (long double);

  extern int signgam;


  extern double __attribute__((__cdecl__)) tgamma (double);
  extern float __attribute__((__cdecl__)) tgammaf (float);
  extern long double __attribute__((__cdecl__)) tgammal (long double);


  extern float __attribute__((__cdecl__)) ceilf (float);
  extern long double __attribute__((__cdecl__)) ceill (long double);


  extern float __attribute__((__cdecl__)) floorf (float);
  extern long double __attribute__((__cdecl__)) floorl (long double);


  extern double __attribute__((__cdecl__)) nearbyint ( double);
  extern float __attribute__((__cdecl__)) nearbyintf (float);
  extern long double __attribute__((__cdecl__)) nearbyintl (long double);



extern double __attribute__((__cdecl__)) rint (double);
extern float __attribute__((__cdecl__)) rintf (float);
extern long double __attribute__((__cdecl__)) rintl (long double);


extern long __attribute__((__cdecl__)) lrint (double);
extern long __attribute__((__cdecl__)) lrintf (float);
extern long __attribute__((__cdecl__)) lrintl (long double);

__extension__ long long __attribute__((__cdecl__)) llrint (double);
__extension__ long long __attribute__((__cdecl__)) llrintf (float);
__extension__ long long __attribute__((__cdecl__)) llrintl (long double);



  extern double __attribute__((__cdecl__)) round (double);
  extern float __attribute__((__cdecl__)) roundf (float);
  extern long double __attribute__((__cdecl__)) roundl (long double);


  extern long __attribute__((__cdecl__)) lround (double);
  extern long __attribute__((__cdecl__)) lroundf (float);
  extern long __attribute__((__cdecl__)) lroundl (long double);
  __extension__ long long __attribute__((__cdecl__)) llround (double);
  __extension__ long long __attribute__((__cdecl__)) llroundf (float);
  __extension__ long long __attribute__((__cdecl__)) llroundl (long double);



  extern double __attribute__((__cdecl__)) trunc (double);
  extern float __attribute__((__cdecl__)) truncf (float);
  extern long double __attribute__((__cdecl__)) truncl (long double);


  extern float __attribute__((__cdecl__)) fmodf (float, float);
  extern long double __attribute__((__cdecl__)) fmodl (long double, long double);


  extern double __attribute__((__cdecl__)) remainder (double, double);
  extern float __attribute__((__cdecl__)) remainderf (float, float);
  extern long double __attribute__((__cdecl__)) remainderl (long double, long double);


  extern double __attribute__((__cdecl__)) remquo(double, double, int *);
  extern float __attribute__((__cdecl__)) remquof(float, float, int *);
  extern long double __attribute__((__cdecl__)) remquol(long double, long double, int *);


  extern double __attribute__((__cdecl__)) copysign (double, double);
  extern float __attribute__((__cdecl__)) copysignf (float, float);
  extern long double __attribute__((__cdecl__)) copysignl (long double, long double);
# 927 "C:/msys64/mingw64/include/math.h" 3
  extern double __attribute__((__cdecl__)) nan(const char *tagp);
  extern float __attribute__((__cdecl__)) nanf(const char *tagp);
  extern long double __attribute__((__cdecl__)) nanl(const char *tagp);
# 938 "C:/msys64/mingw64/include/math.h" 3
  extern double __attribute__((__cdecl__)) nextafter (double, double);
  extern float __attribute__((__cdecl__)) nextafterf (float, float);
  extern long double __attribute__((__cdecl__)) nextafterl (long double, long double);


  extern double __attribute__((__cdecl__)) nexttoward (double, long double);
  extern float __attribute__((__cdecl__)) nexttowardf (float, long double);
  extern long double __attribute__((__cdecl__)) nexttowardl (long double, long double);



  extern double __attribute__((__cdecl__)) fdim (double x, double y);
  extern float __attribute__((__cdecl__)) fdimf (float x, float y);
  extern long double __attribute__((__cdecl__)) fdiml (long double x, long double y);







  extern double __attribute__((__cdecl__)) fmax (double, double);
  extern float __attribute__((__cdecl__)) fmaxf (float, float);
  extern long double __attribute__((__cdecl__)) fmaxl (long double, long double);


  extern double __attribute__((__cdecl__)) fmin (double, double);
  extern float __attribute__((__cdecl__)) fminf (float, float);
  extern long double __attribute__((__cdecl__)) fminl (long double, long double);



  extern double __attribute__((__cdecl__)) fma (double, double, double);
  extern float __attribute__((__cdecl__)) fmaf (float, float, float);
  extern long double __attribute__((__cdecl__)) fmal (long double, long double, long double);
# 1021 "C:/msys64/mingw64/include/math.h" 3
   __attribute__ ((__dllimport__)) float __attribute__((__cdecl__)) _copysignf (float _Number,float _Sign);
   __attribute__ ((__dllimport__)) float __attribute__((__cdecl__)) _chgsignf (float _X);
   __attribute__ ((__dllimport__)) float __attribute__((__cdecl__)) _logbf(float _X);
   __attribute__ ((__dllimport__)) float __attribute__((__cdecl__)) _nextafterf(float _X,float _Y);
   __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _finitef(float _X);
   __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _isnanf(float _X);
   __attribute__ ((__dllimport__)) int __attribute__((__cdecl__)) _fpclassf(float _X);



   extern long double __attribute__((__cdecl__)) _chgsignl (long double);
# 1421 "C:/msys64/mingw64/include/math.h" 3
#pragma pack(pop)
# 4 "c/src/main.c" 2
# 1 "c/include/tiff_image_vectorization.h" 1


# 1 "C:/msys64/mingw64/include/tiffio.h" 1 3
# 31 "C:/msys64/mingw64/include/tiffio.h" 3
# 1 "C:/msys64/mingw64/include/tiff.h" 1 3
# 28 "C:/msys64/mingw64/include/tiff.h" 3
# 1 "C:/msys64/mingw64/include/tiffconf.h" 1 3
# 18 "C:/msys64/mingw64/include/tiffconf.h" 3
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stddef.h" 1 3 4
# 1 "C:/msys64/mingw64/include/stddef.h" 1 3 4
# 24 "C:/msys64/mingw64/include/stddef.h" 3 4
  __attribute__ ((__dllimport__)) extern unsigned long __attribute__((__cdecl__)) __threadid(void);

  __attribute__ ((__dllimport__)) extern uintptr_t __attribute__((__cdecl__)) __threadhandle(void);
# 424 "C:/msys64/mingw64/include/stddef.h" 3 4
typedef struct {
  long long __max_align_ll __attribute__((__aligned__(__alignof__(long long))));
  long double __max_align_ld __attribute__((__aligned__(__alignof__(long double))));
} max_align_t;
# 2 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stddef.h" 2 3 4
# 19 "C:/msys64/mingw64/include/tiffconf.h" 2 3
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stdint.h" 1 3 4
# 9 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stdint.h" 3 4
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wpedantic"
# 1 "C:/msys64/mingw64/include/stdint.h" 1 3 4
# 32 "C:/msys64/mingw64/include/stdint.h" 3 4
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stddef.h" 1 3 4
# 1 "C:/msys64/mingw64/include/stddef.h" 1 3 4
# 2 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stddef.h" 2 3 4
# 33 "C:/msys64/mingw64/include/stdint.h" 2 3 4


typedef signed char int8_t;
typedef unsigned char uint8_t;
typedef short int16_t;
typedef unsigned short uint16_t;
typedef int int32_t;
typedef unsigned uint32_t;
__extension__ typedef long long int64_t;
__extension__ typedef unsigned long long uint64_t;


typedef signed char int_least8_t;
typedef unsigned char uint_least8_t;
typedef short int_least16_t;
typedef unsigned short uint_least16_t;
typedef int int_least32_t;
typedef unsigned uint_least32_t;
__extension__ typedef long long int_least64_t;
__extension__ typedef unsigned long long uint_least64_t;





typedef signed char int_fast8_t;
typedef unsigned char uint_fast8_t;
typedef short int_fast16_t;
typedef unsigned short uint_fast16_t;
typedef int int_fast32_t;
typedef unsigned int uint_fast32_t;
__extension__ typedef long long int_fast64_t;
__extension__ typedef unsigned long long uint_fast64_t;


__extension__ typedef long long intmax_t;
__extension__ typedef unsigned long long uintmax_t;
# 12 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stdint.h" 2 3 4
#pragma GCC diagnostic pop
# 20 "C:/msys64/mingw64/include/tiffconf.h" 2 3
# 1 "C:/msys64/mingw64/include/inttypes.h" 1 3
# 14 "C:/msys64/mingw64/include/inttypes.h" 3
# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stddef.h" 1 3 4
# 1 "C:/msys64/mingw64/include/stddef.h" 1 3 4
# 2 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stddef.h" 2 3 4
# 15 "C:/msys64/mingw64/include/inttypes.h" 2 3





typedef struct {
 intmax_t quot;
 intmax_t rem;
 } imaxdiv_t;
# 327 "C:/msys64/mingw64/include/inttypes.h" 3
intmax_t __attribute__((__cdecl__)) imaxabs (intmax_t j);




imaxdiv_t __attribute__((__cdecl__)) imaxdiv (intmax_t numer, intmax_t denom);



intmax_t __attribute__((__cdecl__)) strtoimax (const char* __restrict__ nptr,
                            char** __restrict__ endptr, int base);
uintmax_t __attribute__((__cdecl__)) strtoumax (const char* __restrict__ nptr,
        char** __restrict__ endptr, int base);

intmax_t __attribute__((__cdecl__)) wcstoimax (const wchar_t* __restrict__ nptr,
                            wchar_t** __restrict__ endptr, int base);
uintmax_t __attribute__((__cdecl__)) wcstoumax (const wchar_t* __restrict__ nptr,
        wchar_t** __restrict__ endptr, int base);
# 21 "C:/msys64/mingw64/include/tiffconf.h" 2 3
# 29 "C:/msys64/mingw64/include/tiff.h" 2 3
# 79 "C:/msys64/mingw64/include/tiff.h" 3
typedef int8_t int8 __attribute__((deprecated));
typedef uint8_t uint8 __attribute__((deprecated));

typedef int16_t int16 __attribute__((deprecated));
typedef uint16_t uint16 __attribute__((deprecated));

typedef int32_t int32 __attribute__((deprecated));
typedef uint32_t uint32 __attribute__((deprecated));

typedef int64_t int64 __attribute__((deprecated));
typedef uint64_t uint64 __attribute__((deprecated));
# 100 "C:/msys64/mingw64/include/tiff.h" 3
typedef int uint16_vap;




typedef struct
{
    uint16_t tiff_magic;
    uint16_t tiff_version;
} TIFFHeaderCommon;
typedef struct
{
    uint16_t tiff_magic;
    uint16_t tiff_version;
    uint32_t tiff_diroff;
} TIFFHeaderClassic;
typedef struct
{
    uint16_t tiff_magic;
    uint16_t tiff_version;
    uint16_t tiff_offsetsize;
    uint16_t tiff_unused;
    uint64_t tiff_diroff;
} TIFFHeaderBig;
# 145 "C:/msys64/mingw64/include/tiff.h" 3
typedef enum
{
    TIFF_NOTYPE = 0,
    TIFF_BYTE = 1,
    TIFF_ASCII = 2,
    TIFF_SHORT = 3,
    TIFF_LONG = 4,
    TIFF_RATIONAL = 5,
    TIFF_SBYTE = 6,
    TIFF_UNDEFINED = 7,
    TIFF_SSHORT = 8,
    TIFF_SLONG = 9,
    TIFF_SRATIONAL = 10,
    TIFF_FLOAT = 11,
    TIFF_DOUBLE = 12,
    TIFF_IFD = 13,
    TIFF_LONG8 = 16,
    TIFF_SLONG8 = 17,
    TIFF_IFD8 = 18
} TIFFDataType;
# 32 "C:/msys64/mingw64/include/tiffio.h" 2 3
# 1 "C:/msys64/mingw64/include/tiffvers.h" 1 3
# 33 "C:/msys64/mingw64/include/tiffio.h" 2 3





typedef struct tiff TIFF;
# 67 "C:/msys64/mingw64/include/tiffio.h" 3
typedef int64_t tmsize_t;


typedef uint64_t toff_t;
typedef uint32_t tdir_t;



typedef uint32_t ttag_t;
typedef uint16_t tsample_t;
typedef uint32_t tstrile_t;
typedef tstrile_t tstrip_t;
typedef tstrile_t ttile_t;
typedef tmsize_t tsize_t;
typedef void *tdata_t;
# 106 "C:/msys64/mingw64/include/tiffio.h" 3
typedef void *thandle_t;
# 138 "C:/msys64/mingw64/include/tiffio.h" 3
typedef unsigned char TIFFRGBValue;

typedef struct
{
    float d_mat[3][3];
    float d_YCR;
    float d_YCG;
    float d_YCB;
    uint32_t d_Vrwr;
    uint32_t d_Vrwg;
    uint32_t d_Vrwb;
    float d_Y0R;
    float d_Y0G;
    float d_Y0B;
    float d_gammaR;
    float d_gammaG;
    float d_gammaB;
} TIFFDisplay;
# 169 "C:/msys64/mingw64/include/tiffio.h" 3
typedef struct
{
    TIFFRGBValue *clamptab;
    int *Cr_r_tab;
    int *Cb_b_tab;
    int32_t *Cr_g_tab;
    int32_t *Cb_g_tab;
    int32_t *Y_tab;
} TIFFYCbCrToRGB;

typedef struct
{
    int range;

    float rstep, gstep, bstep;
    float X0, Y0, Z0;
    TIFFDisplay display;
    float Yr2r[1500 + 1];
    float Yg2g[1500 + 1];
    float Yb2b[1500 + 1];
} TIFFCIELabToRGB;




typedef struct _TIFFRGBAImage TIFFRGBAImage;
# 205 "C:/msys64/mingw64/include/tiffio.h" 3
typedef void (*tileContigRoutine)(TIFFRGBAImage *, uint32_t *, uint32_t,
                                  uint32_t, uint32_t, uint32_t, int32_t,
                                  int32_t, unsigned char *);
typedef void (*tileSeparateRoutine)(TIFFRGBAImage *, uint32_t *, uint32_t,
                                    uint32_t, uint32_t, uint32_t, int32_t,
                                    int32_t, unsigned char *, unsigned char *,
                                    unsigned char *, unsigned char *);



struct _TIFFRGBAImage
{
    TIFF *tif;
    int stoponerr;
    int isContig;
    int alpha;
    uint32_t width;
    uint32_t height;
    uint16_t bitspersample;
    uint16_t samplesperpixel;
    uint16_t orientation;
    uint16_t req_orientation;
    uint16_t photometric;
    uint16_t *redcmap;
    uint16_t *greencmap;
    uint16_t *bluecmap;

    int (*get)(TIFFRGBAImage *, uint32_t *, uint32_t, uint32_t);

    union
    {
        void (*any)(TIFFRGBAImage *);
        tileContigRoutine contig;
        tileSeparateRoutine separate;
    } put;
    TIFFRGBValue *Map;
    uint32_t **BWmap;
    uint32_t **PALmap;
    TIFFYCbCrToRGB *ycbcr;
    TIFFCIELabToRGB *cielab;

    uint8_t *UaToAa;
    uint8_t *Bitdepth16To8;

    int row_offset;
    int col_offset;
};
# 269 "C:/msys64/mingw64/include/tiffio.h" 3
typedef int (*TIFFInitMethod)(TIFF *, int);
typedef struct
{
    char *name;
    uint16_t scheme;
    TIFFInitMethod init;
} TIFFCodec;

typedef struct
{
    uint32_t uNum;
    uint32_t uDenom;
} TIFFRational_t;

# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stdarg.h" 1 3 4
# 1 "C:/msys64/mingw64/include/stdarg.h" 1 3 4
# 140 "C:/msys64/mingw64/include/stdarg.h" 3 4
# 1 "C:/msys64/mingw64/include/_mingw_stdarg.h" 1 3 4
# 141 "C:/msys64/mingw64/include/stdarg.h" 2 3 4
# 2 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stdarg.h" 2 3 4
# 284 "C:/msys64/mingw64/include/tiffio.h" 2 3
# 301 "C:/msys64/mingw64/include/tiffio.h" 3
    typedef void (*TIFFErrorHandler)(const char *, const char *, va_list);
    typedef void (*TIFFErrorHandlerExt)(thandle_t, const char *, const char *,
                                        va_list);
    typedef int (*TIFFErrorHandlerExtR)(TIFF *, void *user_data, const char *,
                                        const char *, va_list);
    typedef tmsize_t (*TIFFReadWriteProc)(thandle_t, void *, tmsize_t);
    typedef toff_t (*TIFFSeekProc)(thandle_t, toff_t, int);
    typedef int (*TIFFCloseProc)(thandle_t);
    typedef toff_t (*TIFFSizeProc)(thandle_t);
    typedef int (*TIFFMapFileProc)(thandle_t, void **base, toff_t *size);
    typedef void (*TIFFUnmapFileProc)(thandle_t, void *base, toff_t size);
    typedef void (*TIFFExtendProc)(TIFF *);

    extern const char *TIFFGetVersion(void);

    extern const TIFFCodec *TIFFFindCODEC(uint16_t);
    extern TIFFCodec *TIFFRegisterCODEC(uint16_t, const char *, TIFFInitMethod);
    extern void TIFFUnRegisterCODEC(TIFFCodec *);
    extern int TIFFIsCODECConfigured(uint16_t);
    extern TIFFCodec *TIFFGetConfiguredCODECs(void);





    extern void *_TIFFmalloc(tmsize_t s);
    extern void *_TIFFcalloc(tmsize_t nmemb, tmsize_t siz);
    extern void *_TIFFrealloc(void *p, tmsize_t s);
    extern void _TIFFfree(void *p);

    extern void _TIFFmemset(void *p, int v, tmsize_t c);
    extern void _TIFFmemcpy(void *d, const void *s, tmsize_t c);
    extern int _TIFFmemcmp(const void *p1, const void *p2, tmsize_t c);




    extern int TIFFGetTagListCount(TIFF *);
    extern uint32_t TIFFGetTagListEntry(TIFF *, int tag_index);
# 348 "C:/msys64/mingw64/include/tiffio.h" 3
    typedef struct _TIFFField TIFFField;
    typedef struct _TIFFFieldArray TIFFFieldArray;

    extern const TIFFField *TIFFFindField(TIFF *, uint32_t, TIFFDataType);
    extern const TIFFField *TIFFFieldWithTag(TIFF *, uint32_t);
    extern const TIFFField *TIFFFieldWithName(TIFF *, const char *);

    extern uint32_t TIFFFieldTag(const TIFFField *);
    extern const char *TIFFFieldName(const TIFFField *);
    extern TIFFDataType TIFFFieldDataType(const TIFFField *);
    extern int TIFFFieldPassCount(const TIFFField *);
    extern int TIFFFieldReadCount(const TIFFField *);
    extern int TIFFFieldWriteCount(const TIFFField *);
    extern int
    TIFFFieldSetGetSize(const TIFFField *);

    extern int TIFFFieldSetGetCountSize(
        const TIFFField *);

    extern int TIFFFieldIsAnonymous(const TIFFField *);

    typedef int (*TIFFVSetMethod)(TIFF *, uint32_t, va_list);
    typedef int (*TIFFVGetMethod)(TIFF *, uint32_t, va_list);
    typedef void (*TIFFPrintMethod)(TIFF *, FILE *, long);

    typedef struct
    {
        TIFFVSetMethod vsetfield;
        TIFFVGetMethod vgetfield;
        TIFFPrintMethod printdir;
    } TIFFTagMethods;

    extern TIFFTagMethods *TIFFAccessTagMethods(TIFF *);
    extern void *TIFFGetClientInfo(TIFF *, const char *);
    extern void TIFFSetClientInfo(TIFF *, void *, const char *);

    extern void TIFFCleanup(TIFF *tif);
    extern void TIFFClose(TIFF *tif);
    extern int TIFFFlush(TIFF *tif);
    extern int TIFFFlushData(TIFF *tif);
    extern int TIFFGetField(TIFF *tif, uint32_t tag, ...);
    extern int TIFFVGetField(TIFF *tif, uint32_t tag, va_list ap);
    extern int TIFFGetFieldDefaulted(TIFF *tif, uint32_t tag, ...);
    extern int TIFFVGetFieldDefaulted(TIFF *tif, uint32_t tag, va_list ap);
    extern int TIFFReadDirectory(TIFF *tif);
    extern int TIFFReadCustomDirectory(TIFF *tif, toff_t diroff,
                                       const TIFFFieldArray *infoarray);
    extern int TIFFReadEXIFDirectory(TIFF *tif, toff_t diroff);
    extern int TIFFReadGPSDirectory(TIFF *tif, toff_t diroff);
    extern uint64_t TIFFScanlineSize64(TIFF *tif);
    extern tmsize_t TIFFScanlineSize(TIFF *tif);
    extern uint64_t TIFFRasterScanlineSize64(TIFF *tif);
    extern tmsize_t TIFFRasterScanlineSize(TIFF *tif);
    extern uint64_t TIFFStripSize64(TIFF *tif);
    extern tmsize_t TIFFStripSize(TIFF *tif);
    extern uint64_t TIFFRawStripSize64(TIFF *tif, uint32_t strip);
    extern tmsize_t TIFFRawStripSize(TIFF *tif, uint32_t strip);
    extern uint64_t TIFFVStripSize64(TIFF *tif, uint32_t nrows);
    extern tmsize_t TIFFVStripSize(TIFF *tif, uint32_t nrows);
    extern uint64_t TIFFTileRowSize64(TIFF *tif);
    extern tmsize_t TIFFTileRowSize(TIFF *tif);
    extern uint64_t TIFFTileSize64(TIFF *tif);
    extern tmsize_t TIFFTileSize(TIFF *tif);
    extern uint64_t TIFFVTileSize64(TIFF *tif, uint32_t nrows);
    extern tmsize_t TIFFVTileSize(TIFF *tif, uint32_t nrows);
    extern uint32_t TIFFDefaultStripSize(TIFF *tif, uint32_t request);
    extern void TIFFDefaultTileSize(TIFF *, uint32_t *, uint32_t *);
    extern int TIFFFileno(TIFF *);
    extern int TIFFSetFileno(TIFF *, int);
    extern thandle_t TIFFClientdata(TIFF *);
    extern thandle_t TIFFSetClientdata(TIFF *, thandle_t);
    extern int TIFFGetMode(TIFF *);
    extern int TIFFSetMode(TIFF *, int);
    extern int TIFFIsTiled(TIFF *);
    extern int TIFFIsByteSwapped(TIFF *);
    extern int TIFFIsUpSampled(TIFF *);
    extern int TIFFIsMSB2LSB(TIFF *);
    extern int TIFFIsBigEndian(TIFF *);
    extern int TIFFIsBigTIFF(TIFF *);
    extern TIFFReadWriteProc TIFFGetReadProc(TIFF *);
    extern TIFFReadWriteProc TIFFGetWriteProc(TIFF *);
    extern TIFFSeekProc TIFFGetSeekProc(TIFF *);
    extern TIFFCloseProc TIFFGetCloseProc(TIFF *);
    extern TIFFSizeProc TIFFGetSizeProc(TIFF *);
    extern TIFFMapFileProc TIFFGetMapFileProc(TIFF *);
    extern TIFFUnmapFileProc TIFFGetUnmapFileProc(TIFF *);
    extern uint32_t TIFFCurrentRow(TIFF *);
    extern tdir_t TIFFCurrentDirectory(TIFF *);
    extern tdir_t TIFFNumberOfDirectories(TIFF *);
    extern uint64_t TIFFCurrentDirOffset(TIFF *);
    extern uint32_t TIFFCurrentStrip(TIFF *);
    extern uint32_t TIFFCurrentTile(TIFF *tif);
    extern int TIFFReadBufferSetup(TIFF *tif, void *bp, tmsize_t size);
    extern int TIFFWriteBufferSetup(TIFF *tif, void *bp, tmsize_t size);
    extern int TIFFSetupStrips(TIFF *);
    extern int TIFFWriteCheck(TIFF *, int, const char *);
    extern void TIFFFreeDirectory(TIFF *);
    extern int TIFFCreateDirectory(TIFF *);
    extern int TIFFCreateCustomDirectory(TIFF *, const TIFFFieldArray *);
    extern int TIFFCreateEXIFDirectory(TIFF *);
    extern int TIFFCreateGPSDirectory(TIFF *);
    extern int TIFFLastDirectory(TIFF *);
    extern int TIFFSetDirectory(TIFF *, tdir_t);
    extern int TIFFSetSubDirectory(TIFF *, uint64_t);
    extern int TIFFUnlinkDirectory(TIFF *, tdir_t);
    extern int TIFFSetField(TIFF *, uint32_t, ...);
    extern int TIFFVSetField(TIFF *, uint32_t, va_list);
    extern int TIFFUnsetField(TIFF *, uint32_t);
    extern int TIFFWriteDirectory(TIFF *);
    extern int TIFFWriteCustomDirectory(TIFF *, uint64_t *);
    extern int TIFFCheckpointDirectory(TIFF *);
    extern int TIFFRewriteDirectory(TIFF *);
    extern int TIFFDeferStrileArrayWriting(TIFF *);
    extern int TIFFForceStrileArrayWriting(TIFF *);
# 474 "C:/msys64/mingw64/include/tiffio.h" 3
extern void TIFFPrintDirectory(TIFF *, FILE *, long);
extern int TIFFReadScanline(TIFF *tif, void *buf, uint32_t row,
                            uint16_t sample);
extern int TIFFWriteScanline(TIFF *tif, void *buf, uint32_t row,
                             uint16_t sample);
extern int TIFFReadRGBAImage(TIFF *, uint32_t, uint32_t, uint32_t *, int);
extern int TIFFReadRGBAImageOriented(TIFF *, uint32_t, uint32_t, uint32_t *,
                                     int, int);


    extern int TIFFReadRGBAStrip(TIFF *, uint32_t, uint32_t *);
    extern int TIFFReadRGBATile(TIFF *, uint32_t, uint32_t, uint32_t *);
    extern int TIFFReadRGBAStripExt(TIFF *, uint32_t, uint32_t *,
                                    int stop_on_error);
    extern int TIFFReadRGBATileExt(TIFF *, uint32_t, uint32_t, uint32_t *,
                                   int stop_on_error);
    extern int TIFFRGBAImageOK(TIFF *, char[1024]);
    extern int TIFFRGBAImageBegin(TIFFRGBAImage *, TIFF *, int, char[1024]);
    extern int TIFFRGBAImageGet(TIFFRGBAImage *, uint32_t *, uint32_t,
                                uint32_t);
    extern void TIFFRGBAImageEnd(TIFFRGBAImage *);

    extern const char *TIFFFileName(TIFF *);
    extern const char *TIFFSetFileName(TIFF *, const char *);
    extern void TIFFError(const char *, const char *, ...)
        __attribute__((__format__(__printf__, 2, 3)));
    extern void TIFFErrorExt(thandle_t, const char *, const char *, ...)
        __attribute__((__format__(__printf__, 3, 4)));
    extern void TIFFWarning(const char *, const char *, ...)
        __attribute__((__format__(__printf__, 2, 3)));
    extern void TIFFWarningExt(thandle_t, const char *, const char *, ...)
        __attribute__((__format__(__printf__, 3, 4)));
    extern TIFFErrorHandler TIFFSetErrorHandler(TIFFErrorHandler);
    extern TIFFErrorHandlerExt TIFFSetErrorHandlerExt(TIFFErrorHandlerExt);
    extern TIFFErrorHandler TIFFSetWarningHandler(TIFFErrorHandler);
    extern TIFFErrorHandlerExt TIFFSetWarningHandlerExt(TIFFErrorHandlerExt);

    extern void TIFFWarningExtR(TIFF *, const char *, const char *, ...)
        __attribute__((__format__(__printf__, 3, 4)));
    extern void TIFFErrorExtR(TIFF *, const char *, const char *, ...)
        __attribute__((__format__(__printf__, 3, 4)));

    typedef struct TIFFOpenOptions TIFFOpenOptions;
    extern TIFFOpenOptions *TIFFOpenOptionsAlloc(void);
    extern void TIFFOpenOptionsFree(TIFFOpenOptions *);
    extern void
    TIFFOpenOptionsSetMaxSingleMemAlloc(TIFFOpenOptions *opts,
                                        tmsize_t max_single_mem_alloc);
    extern void
    TIFFOpenOptionsSetMaxCumulatedMemAlloc(TIFFOpenOptions *opts,
                                           tmsize_t max_cumulated_mem_alloc);
    extern void
    TIFFOpenOptionsSetWarnAboutUnknownTags(TIFFOpenOptions *opts,
                                           int warn_about_unknown_tags);
    extern void
    TIFFOpenOptionsSetErrorHandlerExtR(TIFFOpenOptions *opts,
                                       TIFFErrorHandlerExtR handler,
                                       void *errorhandler_user_data);
    extern void
    TIFFOpenOptionsSetWarningHandlerExtR(TIFFOpenOptions *opts,
                                         TIFFErrorHandlerExtR handler,
                                         void *warnhandler_user_data);

    extern TIFF *TIFFOpen(const char *, const char *);
    extern TIFF *TIFFOpenExt(const char *, const char *, TIFFOpenOptions *opts);

    extern TIFF *TIFFOpenW(const wchar_t *, const char *);
    extern TIFF *TIFFOpenWExt(const wchar_t *, const char *,
                              TIFFOpenOptions *opts);

    extern TIFF *TIFFFdOpen(int, const char *, const char *);
    extern TIFF *TIFFFdOpenExt(int, const char *, const char *,
                               TIFFOpenOptions *opts);
    extern TIFF *TIFFClientOpen(const char *, const char *, thandle_t,
                                TIFFReadWriteProc, TIFFReadWriteProc,
                                TIFFSeekProc, TIFFCloseProc, TIFFSizeProc,
                                TIFFMapFileProc, TIFFUnmapFileProc);
    extern TIFF *TIFFClientOpenExt(const char *, const char *, thandle_t,
                                   TIFFReadWriteProc, TIFFReadWriteProc,
                                   TIFFSeekProc, TIFFCloseProc, TIFFSizeProc,
                                   TIFFMapFileProc, TIFFUnmapFileProc,
                                   TIFFOpenOptions *opts);
    extern TIFFExtendProc TIFFSetTagExtender(TIFFExtendProc);
    extern uint32_t TIFFComputeTile(TIFF *tif, uint32_t x, uint32_t y,
                                    uint32_t z, uint16_t s);
    extern int TIFFCheckTile(TIFF *tif, uint32_t x, uint32_t y, uint32_t z,
                             uint16_t s);
    extern uint32_t TIFFNumberOfTiles(TIFF *);
    extern tmsize_t TIFFReadTile(TIFF *tif, void *buf, uint32_t x, uint32_t y,
                                 uint32_t z, uint16_t s);
    extern tmsize_t TIFFWriteTile(TIFF *tif, void *buf, uint32_t x, uint32_t y,
                                  uint32_t z, uint16_t s);
    extern uint32_t TIFFComputeStrip(TIFF *, uint32_t, uint16_t);
    extern uint32_t TIFFNumberOfStrips(TIFF *);
    extern tmsize_t TIFFReadEncodedStrip(TIFF *tif, uint32_t strip, void *buf,
                                         tmsize_t size);
    extern tmsize_t TIFFReadRawStrip(TIFF *tif, uint32_t strip, void *buf,
                                     tmsize_t size);
    extern tmsize_t TIFFReadEncodedTile(TIFF *tif, uint32_t tile, void *buf,
                                        tmsize_t size);
    extern tmsize_t TIFFReadRawTile(TIFF *tif, uint32_t tile, void *buf,
                                    tmsize_t size);
    extern int TIFFReadFromUserBuffer(TIFF *tif, uint32_t strile, void *inbuf,
                                      tmsize_t insize, void *outbuf,
                                      tmsize_t outsize);
    extern tmsize_t TIFFWriteEncodedStrip(TIFF *tif, uint32_t strip, void *data,
                                          tmsize_t cc);
    extern tmsize_t TIFFWriteRawStrip(TIFF *tif, uint32_t strip, void *data,
                                      tmsize_t cc);
    extern tmsize_t TIFFWriteEncodedTile(TIFF *tif, uint32_t tile, void *data,
                                         tmsize_t cc);
    extern tmsize_t TIFFWriteRawTile(TIFF *tif, uint32_t tile, void *data,
                                     tmsize_t cc);
    extern int TIFFDataWidth(
        TIFFDataType);
    extern void TIFFSetWriteOffset(TIFF *tif, toff_t off);
    extern void TIFFSwabShort(uint16_t *);
    extern void TIFFSwabLong(uint32_t *);
    extern void TIFFSwabLong8(uint64_t *);
    extern void TIFFSwabFloat(float *);
    extern void TIFFSwabDouble(double *);
    extern void TIFFSwabArrayOfShort(uint16_t *wp, tmsize_t n);
    extern void TIFFSwabArrayOfTriples(uint8_t *tp, tmsize_t n);
    extern void TIFFSwabArrayOfLong(uint32_t *lp, tmsize_t n);
    extern void TIFFSwabArrayOfLong8(uint64_t *lp, tmsize_t n);
    extern void TIFFSwabArrayOfFloat(float *fp, tmsize_t n);
    extern void TIFFSwabArrayOfDouble(double *dp, tmsize_t n);
    extern void TIFFReverseBits(uint8_t *cp, tmsize_t n);
    extern const unsigned char *TIFFGetBitRevTable(int);

    extern uint64_t TIFFGetStrileOffset(TIFF *tif, uint32_t strile);
    extern uint64_t TIFFGetStrileByteCount(TIFF *tif, uint32_t strile);
    extern uint64_t TIFFGetStrileOffsetWithErr(TIFF *tif, uint32_t strile,
                                               int *pbErr);
    extern uint64_t TIFFGetStrileByteCountWithErr(TIFF *tif, uint32_t strile,
                                                  int *pbErr);





    extern double LogL16toY(int);
    extern double LogL10toY(int);
    extern void XYZtoRGB24(float *, uint8_t *);
    extern int uv_decode(double *, double *, int);
    extern void LogLuv24toXYZ(uint32_t, float *);
    extern void LogLuv32toXYZ(uint32_t, float *);







    extern int LogL16fromY(double, int);
    extern int LogL10fromY(double, int);
    extern int uv_encode(double, double, int);
    extern uint32_t LogLuv24fromXYZ(float *, int);
    extern uint32_t LogLuv32fromXYZ(float *, int);



    extern int TIFFCIELabToRGBInit(TIFFCIELabToRGB *, const TIFFDisplay *,
                                   float *);
    extern void TIFFCIELabToXYZ(TIFFCIELabToRGB *, uint32_t, int32_t, int32_t,
                                float *, float *, float *);
    extern void TIFFXYZToRGB(TIFFCIELabToRGB *, float, float, float, uint32_t *,
                             uint32_t *, uint32_t *);

    extern int TIFFYCbCrToRGBInit(TIFFYCbCrToRGB *, float *, float *);
    extern void TIFFYCbCrtoRGB(TIFFYCbCrToRGB *, uint32_t, int32_t, int32_t,
                               uint32_t *, uint32_t *, uint32_t *);







    typedef struct
    {
        uint32_t field_tag;
        short field_readcount;
        short field_writecount;
        TIFFDataType field_type;
        unsigned short field_bit;
        unsigned char field_oktochange;
        unsigned char field_passcount;
        char *field_name;
    } TIFFFieldInfo;

    extern int TIFFMergeFieldInfo(TIFF *, const TIFFFieldInfo[], uint32_t);
# 4 "c/include/tiff_image_vectorization.h" 2


# 5 "c/include/tiff_image_vectorization.h"
typedef struct {
    int width;
    int height;
    int channels;
    float* data;
} ImageTensor;

int read_tiff_info(const char* filename,
                   int* width,
                   int* height,
                   int* channels);

ImageTensor* load_tiff_as_tensor(const char* filename);
# 5 "c/src/main.c" 2
# 1 "c/include/kd_tree.h" 1



typedef float* point_t;

typedef struct {
    point_t v;
    int x;
    int y;
    int axis;
    float max_angle;
} point;


typedef struct kd_node {
    point point;
    int axis;
    struct kd_node *left;
    struct kd_node *right;
} kd_node;

typedef struct {
    point point_;
    float dist2;
} knn_item;

void kd_knn(const kd_node *root, point query, int k, knn_item *out);



kd_node* kd_create_node(point point, int axis);
kd_node* kd_build(point *points_, size_t n, int depth);
void kd_free(kd_node *node);
# 6 "c/src/main.c" 2
# 1 "c/include/knn_operations.h" 1



# 1 "C:/msys64/mingw64/lib/gcc/x86_64-w64-mingw32/15.2.0/include/stdbool.h" 1 3 4
# 5 "c/include/knn_operations.h" 2
# 1 "c/include/kd_tree.h" 1
# 6 "c/include/knn_operations.h" 2



typedef struct {
    int* cluster_ids;
    double* border_degrees;
    bool* is_border;
    int num_pixels;
} ClusteringResults;

void vector_subtraction(const float* vector_1, const float* vector_2, float* result_vector, int dims);

float vector_magnitude(const float* vector, int dims);

float vector_dot_product(const float* vector_1, const float* vector_2, int dims);

float vector_compute_angle(const float* vector_1, const float* vector_2, int dims);

void vector_mean_of_neighbors(const knn_item* neighbors , int k, float* vector_mean, int dims);

void vector_angle_result(const point* query_point, const knn_item *neighbors , int k, int dims, float *angles);

void updated_max_angles(const kd_node* tree, const point* points, int n_points, int k, int dims, int width, int height, float* angles_array);
# 7 "c/src/main.c" 2



int main(int argc, char *argv[]) {

    ImageTensor* img = load_tiff_as_tensor("data/sentinel_tensor_10m.tiff");

    if (!img) {
        printf("Error loading TIFF\n");
        return 1;
    }


    size_t n_points = (size_t)img->width * img->height;
    point *points = malloc(n_points * sizeof(point));
    if (!points) {
        printf("Error allocating pixel pointers memory");
        return 1;
    }


    for (size_t i = 0; i < n_points; i++) {
        points[i].v = img->data + (i * img->channels);
        points[i].x = i % img->width;
        points[i].y = i / img->width;
    }

    kd_node *tree = kd_build(points, n_points, 0);


    FILE *file_pointer;
    file_pointer = fopen("text.txt", "w");
    if (file_pointer == 
# 39 "c/src/main.c" 3 4
                       ((void *)0)
# 39 "c/src/main.c"
                           ) {
        printf("Error opening the file!\n");
        return 1;
    }


    int width = img->width; int height = img->height;
    float angle_map[width][height];
    updated_max_angles(tree, points, n_points, 5, 15, width, height, (float *)angle_map);
    for (int i = 0; i < (width/30); i++){
        for (int j = 0; j < (height/30); j++){
            double angle_max_degrees = angle_map[i][j]*180/3.1415;
            fprintf(file_pointer, "[%.2f°]", angle_max_degrees);
        }
        fprintf(file_pointer, "\n");
    }

    float p20 = percentile((float *)angle_map, width*height, 20.0f);

    fprintf(file_pointer, "\n/////////////////////\n20\% value of the barrier: %f", p20);
    fprintf(file_pointer, "\n");
    for (int i = 0; i < (width/30); i++){
        for (int j = 0; j < (height/30); j++){
            double angle_max_degrees = angle_map[i][j]*180/3.1415;
            if(angle_map[i][j] < p20)
            fprintf(file_pointer, "[%.2f°]", angle_max_degrees);
        }
        fprintf(file_pointer, "\n");
    }


    fclose(file_pointer);


    kd_free(tree);
    free(points);
    free(img->data);
    free(img);
}
