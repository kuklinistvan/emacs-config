# István's .emacs

A bit chaotic but not that hard to install.

## Features

- C/C++ editing: LSP features, rudimentary CMake support
- (that's all currently)

## Installation

Copy or symlink `.emacs` and `.emacs.d` under your home directory, then execute

    M-x package-refresh-contents
    M-x package-install-selected-packages

Restart Emacs and enjoy!

## Key bindings

### Ergonomic rebindings

 * C-s, C-v, C-c as outside emacs
 * C-z, C-y: undo/redo
 * C-o: find file
 * C-f: I-Search (after that; C-s, C-r: next, previous)
 * C-n: new frame, Alt+F4: delete frame
 * C-w: kill this buffer 

 * F10: Split window horizontally, F11: split vertically, F12: close window
 * M-left, M-right: previous/next open buffer

 * C-b: list buffers

### Feature triggers

 * F4: header/source switch
 * F5: fuzzy search for content
 * F6: fuzzy search for file
 * F8: treemacs

 * M-up/M-down: lsp next/previous signature hint

 * C-SPC: autocomplete

### Copying

* For `.emacs`:

  ```
  Copyright 2020 Kuklin István Alexander
  
  Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
  
  1. Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
  
  2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
  
  3. Neither the name of the copyright holder nor the names of its contributors may be used to endorse or promote products derived from this software without specific prior written permission.
  
  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  ```

* The KI logo is subject to copyright and shall not be redistributed without permission.

