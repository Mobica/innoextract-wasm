#ifndef EMSCRIPTEN_UPLOAD_FILE_H_INCLUDED
#define EMSCRIPTEN_UPLOAD_FILE_H_INCLUDED

// Based on emscripten-browser-file package by Armchair Software, licensed under MIT
// https://github.com/Armchair-Software/emscripten-browser-file

#ifdef __cplusplus

#include <emscripten.h>
#include <string>

namespace emjs {

using upload_handler = void (*)(std::string const&, std::string const&, std::string_view buffer,
                                void*);

void upload_wrap(std::string const& accept_types, upload_handler callback,
                 void* callback_data = nullptr);
void download_wrap(std::string const& filename, std::string const& mime_type,
                   std::string_view buffer);
void down_wrap(std::string const& filename);
void ui_innerhtml(const char* id, const char* value);
void ui_setattr(const char* id, const char* attr, std::string const& value);
void ui_remattr(const char* id, const char* attr);
void ui_progbar_update(int value);
void ui_show_error();

void open(const char* name, const char* __restrict modes, uint64_t output_size);
size_t write(const void* ptr, size_t size, size_t n);
void close();

namespace {
extern "C" {
EMSCRIPTEN_KEEPALIVE void abort_down();
}
} // namespace

} // namespace emjs

#else
ssize_t emjs_write(void* buf, size_t len);
#endif

#endif // EMSCRIPTEN_UPLOAD_FILE_H_INCLUDED
