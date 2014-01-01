// ========================== KeySnail Init File =========================== //

// この領域は, GUI により設定ファイルを生成した際にも引き継がれます
// 特殊キー, キーバインド定義, フック, ブラックリスト以外のコードは, この中に書くようにして下さい
// ========================================================================= //
//{{%PRESERVE%
// LDRize基本key-bind

plugins.options["ldrnail.keybind"] = {
//  'j': 'next',
    'n': 'next',
//  'k': 'prev',
    'p': 'prev',
//  'p': 'pin',
//  'l': 'list',
    'f': 'focus',
    'v': 'view',
    'o': 'open',
    's': 'siteinfo',
};

// ニコニコ動画再生ページで無効
plugins.options["ldrnail.exclude_urls"] = [
    "^http://www.nicovideo.jp/watch/.*",
];


// Hok
key.setViewKey('E', function (aEvent, aArg) {
    ext.exec("hok-start-foreground-mode", aArg);
}, 'Hit a Hint を開始', true);

key.setViewKey('e', function (aEvent, aArg) {
    ext.exec("hok-start-background-mode", aArg);
}, 'リンクをバックグラウンドで開く Hit a Hint を開始', true);

key.setViewKey(';', function (aEvent, aArg) {
    ext.exec("hok-start-extended-mode", aArg);
}, 'HoK - 拡張ヒントモード', true);

key.setViewKey(['C-c', 'C-e'], function (aEvent, aArg) {
    ext.exec("hok-start-continuous-mode", aArg);
}, 'リンクを連続して開く Hit a Hint を開始', true);

// bmany
key.setViewKey([':', 'b'], function (ev, arg) {
    ext.exec("bmany-list-all-bookmarks", arg, ev);
}, 'ブックマーク');

key.setViewKey([':', 'B'], function (ev, arg) {
    ext.exec("bmany-list-bookmarklets", arg, ev);
}, "bmany - ブックマークレットを一覧表示");

key.setViewKey([':', 'k'], function (ev, arg) {
    ext.exec("bmany-list-bookmarks-with-keyword", arg, ev);
}, "bmany - キーワード付きブックマークを一覧表示");

key.setViewKey([':', 't'], function (ev, arg) {
    ext.exec("bmany-list-bookmarks-with-tag", arg, ev);
}, "bmany - タグ付きブックマークを一覧表示");


// bmany
key.setViewKey([':', 'b'], function (ev, arg) {
    ext.exec("bmany-list-all-bookmarks", arg, ev);
}, 'ブックマーク');

key.setViewKey([':', 'B'], function (ev, arg) {
    ext.exec("bmany-list-bookmarklets", arg, ev);
}, "bmany - ブックマークレットを一覧表示");

key.setViewKey([':', 'k'], function (ev, arg) {
    ext.exec("bmany-list-bookmarks-with-keyword", arg, ev);
}, "bmany - キーワード付きブックマークを一覧表示");

key.setViewKey([':', 't'], function (ev, arg) {
    ext.exec("bmany-list-bookmarks-with-tag", arg, ev);
}, "bmany - タグ付きブックマークを一覧表示");
//}}%PRESERVE%
// ========================================================================= //

// ========================= Special key settings ========================== //

key.quitKey              = "C-g";
key.helpKey              = "<f1>";
key.escapeKey            = "C-q";
key.macroStartKey        = "undefined";
key.macroEndKey          = "undefined";
key.universalArgumentKey = "C-u";
key.negativeArgument1Key = "C--";
key.negativeArgument2Key = "C-M--";
key.negativeArgument3Key = "M--";
key.suspendKey           = "<f2>";

// ================================= Hooks ================================= //


hook.setHook('KeyBoardQuit', function (aEvent) {
    if (key.currentKeySequence.length) return;

    command.closeFindBar();

    let marked = command.marked(aEvent);

    if (util.isCaretEnabled()) {
        if (marked) {
            command.resetMark(aEvent);
        } else {
            if ("blur" in aEvent.target) aEvent.target.blur();

            gBrowser.focus();
            _content.focus();
        }
    } else {
        goDoCommand("cmd_selectNone");
    }

    if (KeySnail.windowType === "navigator:browser" && !marked) {
        key.generateKey(aEvent.originalTarget, KeyEvent.DOM_VK_ESCAPE, true);
    }
});



// ============================= Key bindings ============================== //

key.setGlobalKey('C-M-r', function (ev) {
                userscript.reload();
            }, '設定ファイルを再読み込み', true);

key.setGlobalKey('M-x', function (ev, arg) {
                ext.select(arg, ev);
            }, 'エクステ一覧表示', true);

key.setGlobalKey('?', function (ev) {
                key.listKeyBindings();
            }, 'キーバインド一覧を表示');

key.setGlobalKey('C-m', function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RETURN, true);
            }, 'リターンコードを生成');

key.setGlobalKey(['C-x', 'l'], function (ev) {
                command.focusToById("urlbar");
            }, 'ロケーションバーへフォーカス', true);

key.setGlobalKey(['C-x', 'g'], function (ev) {
                command.focusToById("searchbar");
            }, '検索バーへフォーカス', true);

key.setGlobalKey(['C-x', 't'], function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, '最初のインプットエリアへフォーカス', true);

key.setGlobalKey(['C-x', 's'], function (ev) {
                command.focusElement(command.elementsRetrieverButton, 0);
            }, '最初のボタンへフォーカス', true);

key.setGlobalKey(['C-x', 'k'], function (ev) {
                BrowserCloseTabOrWindow();
            }, 'タブ / ウィンドウを閉じる');

key.setGlobalKey(['C-x', 'n'], function (ev) {
                OpenBrowserWindow();
            }, 'ウィンドウを開く');

key.setGlobalKey(['C-x', 'C-c'], function (ev) {
                goQuitApplication();
            }, 'Firefox を終了', true);

key.setGlobalKey(['C-x', 'o'], function (ev, arg) {
                command.focusOtherFrame(arg);
            }, '次のフレームを選択');

key.setGlobalKey(['C-x', '1'], function (ev) {
                window.loadURI(ev.target.ownerDocument.location.href);
            }, '現在のフレームだけを表示', true);

key.setGlobalKey(['C-x', 'u'], function (ev) {
                undoCloseTab();
            }, '閉じたタブを元に戻す');

key.setGlobalKey('C-s', function (ev) {
                command.iSearchForwardKs(ev);
            }, 'Emacs ライクなインクリメンタル検索', true);

key.setGlobalKey('C-r', function (ev) {
                command.iSearchBackwardKs(ev);
            }, 'Emacs ライクな逆方向インクリメンタル検索', true);

key.setGlobalKey(['C-c', 'C-c', 'C-v'], function (ev) {
                toJavaScriptConsole();
            }, 'Javascript コンソールを表示', true);

key.setGlobalKey(['C-c', 'C-c', 'C-c'], function (ev) {
                command.clearConsole();
            }, 'Javascript コンソールの表示をクリア', true);

key.setGlobalKey('C-M-n', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(1, true);
            }, 'ひとつ右のタブへ');

key.setGlobalKey('C-M-p', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(-1, true);
            }, 'ひとつ左のタブへ');

key.setGlobalKey('M-n', function (ev) {
    command.walkInputElement(command.elementsRetrieverTextarea, true, true);
}, '次のテキストエリアへフォーカス');

key.setGlobalKey('M-p', function (ev) {
    command.walkInputElement(command.elementsRetrieverTextarea, false, true);
}, '前のテキストエリアへフォーカス');

key.setGlobalKey('C-w', function (ev) {
    command.copyRegion(ev);
}, '選択中のテキストをコピー');

key.setGlobalKey('C-n', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
}, '一行スクロールダウン');

key.setGlobalKey('C-p', function (ev) {
    key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
}, '一行スクロールアップ');

key.setGlobalKey([['C-v'], ['M-v']], function (ev) {
    goDoCommand("cmd_scrollPageUp");
}, '一画面分スクロールアップ');

key.setViewKey('E', function (aEvent, aArg) {
    ext.exec("hok-start-foreground-mode", aArg);
}, 'Hit a Hint を開始', true);

key.setViewKey('e', function (aEvent, aArg) {
    ext.exec("hok-start-background-mode", aArg);
}, 'リンクをバックグラウンドで開く Hit a Hint を開始', true);

key.setViewKey(';', function (aEvent, aArg) {
    ext.exec("hok-start-extended-mode", aArg);
}, 'HoK - 拡張ヒントモード', true);

key.setViewKey(['C-c', 'C-e'], function (aEvent, aArg) {
    ext.exec("hok-start-continuous-mode", aArg);
}, 'リンクを連続して開く Hit a Hint を開始', true);

key.setViewKey(['C-c', 'C-r'], function (ev) {
                BrowserReload();
            }, '更新', true);

key.setViewKey(['C-c', 'C-b'], function (ev) {
                BrowserBack();
            }, '戻る');

key.setViewKey(':', function (ev, arg) {
                shell.input(null, arg);
            }, 'コマンドの実行', true);

key.setViewKey([['C-n'], ['j']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_DOWN, true);
            }, '一行スクロールダウン');

key.setViewKey([['C-p'], ['k']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_UP, true);
            }, '一行スクロールアップ');

key.setViewKey([['C-f'], ['.']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_RIGHT, true);
            }, '右へスクロール');

key.setViewKey([['C-b'], [',']], function (ev) {
                key.generateKey(ev.originalTarget, KeyEvent.DOM_VK_LEFT, true);
            }, '左へスクロール');

key.setViewKey([['M-v'], ['b']], function (ev) {
                goDoCommand("cmd_scrollPageUp");
            }, '一画面分スクロールアップ');

key.setViewKey('C-v', function (ev) {
                goDoCommand("cmd_scrollPageDown");
            }, '一画面スクロールダウン');

key.setViewKey([['M-<'], ['g']], function (ev) {
                goDoCommand("cmd_scrollTop");
            }, 'ページ先頭へ移動', true);

key.setViewKey([['M->'], ['G']], function (ev) {
                goDoCommand("cmd_scrollBottom");
            }, 'ページ末尾へ移動', true);

key.setViewKey('l', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(1, true);
            }, 'ひとつ右のタブへ');

key.setViewKey('h', function (ev) {
                getBrowser().mTabContainer.advanceSelectedTab(-1, true);
            }, 'ひとつ左のタブへ');

key.setViewKey('f', function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, '最初のインプットエリアへフォーカス', true);

key.setViewKey(['C-x', 'h'], function (ev) {
                goDoCommand("cmd_selectAll");
            }, 'すべて選択', true);

key.setViewKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, true, true);
            }, '次のボタンへフォーカスを当てる');

key.setViewKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, false, true);
            }, '前のボタンへフォーカスを当てる');

key.setEditKey(['C-x', 'h'], function (ev) {
                command.selectAll(ev);
            }, '全て選択', true);

key.setEditKey([['C-x', 'u'], ['C-z']], function (ev) {
                display.echoStatusBar("Undo!", 2000);
                goDoCommand("cmd_undo");
            }, 'アンドゥ');

key.setEditKey(['C-x', 'r', 'd'], function (ev, arg) {
                command.replaceRectangle(ev.originalTarget, "", false, !arg);
            }, '矩形削除', true);

key.setEditKey(['C-x', 'r', 't'], function (ev) {
                prompt.read("String rectangle: ", function (aStr, aInput) {
                                command.replaceRectangle(aInput, aStr);
                            },
                            ev.originalTarget);
            }, '矩形置換', true);

key.setEditKey(['C-x', 'r', 'o'], function (ev) {
                command.openRectangle(ev.originalTarget);
            }, '矩形行空け', true);

key.setEditKey(['C-x', 'r', 'k'], function (ev, arg) {
                command.kill.buffer = command.killRectangle(ev.originalTarget, !arg);
            }, '矩形キル', true);

key.setEditKey(['C-x', 'r', 'y'], function (ev) {
                command.yankRectangle(ev.originalTarget, command.kill.buffer);
            }, '矩形ヤンク', true);

key.setEditKey([['C-`'], ['C-@']], function (ev) {
                command.setMark(ev);
            }, 'マークをセット', true);

key.setEditKey('C-o', function (ev) {
                command.openLine(ev);
            }, '行を開く (Open line)');

key.setEditKey('C-\\', function (ev) {
                display.echoStatusBar("Redo!", 2000);
                goDoCommand("cmd_redo");
            }, 'リドゥ');

key.setEditKey('C-a', function (ev) {
                command.beginLine(ev);
            }, '行頭へ移動');

key.setEditKey('C-e', function (ev) {
                command.endLine(ev);
            }, '行末へ');

key.setEditKey('C-f', function (ev) {
                command.nextChar(ev);
            }, '一文字右へ移動');

key.setEditKey('C-b', function (ev) {
                command.previousChar(ev);
            }, '一文字左へ移動');

key.setEditKey('C-n', function (ev) {
                command.nextLine(ev);
            }, '一行下へ');

key.setEditKey('C-p', function (ev) {
                command.previousLine(ev);
            }, '一行上へ');

key.setEditKey('C-v', function (ev) {
                command.pageDown(ev);
            }, '一画面分下へ');

key.setEditKey('M-<', function (ev) {
                command.moveTop(ev);
            }, 'テキストエリア先頭へ');

key.setEditKey('M->', function (ev) {
                command.moveBottom(ev);
            }, 'テキストエリア末尾へ');

key.setEditKey('C-d', function (ev) {
                goDoCommand("cmd_deleteCharForward");
            }, '次の一文字削除');

key.setEditKey('C-h', function (ev) {
                goDoCommand("cmd_deleteCharBackward");
            }, '前の一文字を削除');

key.setEditKey([['C-<backspace>'], ['M-<delete>']], function (ev) {
                command.deleteBackwardWord(ev);
            }, '前の一単語を削除');

key.setEditKey('C-k', function (ev) {
                command.killLine(ev);
            }, 'カーソルから先を一行カット (Kill line)');

key.setEditKey('M-y', command.yankPop, '古いクリップボードの中身を順に貼り付け (Yank pop)', true);

key.setEditKey('C-M-y', function (ev) {
                if (!command.kill.ring.length)
                    return;

                let (ct = command.getClipboardText())
                    (!command.kill.ring.length || ct != command.kill.ring[0]) && command.pushKillRing(ct);

                prompt.selector(
                    {
                        message: "Paste:",
                        collection: command.kill.ring,
                        callback: function (i) { if (i >= 0) key.insertText(command.kill.ring[i]); }
                    }
                );
            }, '以前にコピーしたテキスト一覧から選択して貼り付け', true);

key.setCaretKey([['C-a'], ['^']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectBeginLine") : goDoCommand("cmd_beginLine");
            }, 'キャレットを行頭へ移動');

key.setCaretKey([['C-e'], ['$'], ['M->'], ['G']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectEndLine") : goDoCommand("cmd_endLine");
            }, 'キャレットを行末へ移動');

key.setCaretKey('C-n', function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
            }, 'キャレットを一行下へ');

key.setCaretKey('C-p', function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
            }, 'キャレットを一行上へ');

key.setCaretKey([['C-f'], ['l']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectCharNext") : goDoCommand("cmd_scrollRight");
            }, 'キャレットを一文字右へ移動');

key.setCaretKey([['C-b'], ['h'], ['C-h']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectCharPrevious") : goDoCommand("cmd_scrollLeft");
            }, 'キャレットを一文字左へ移動');

key.setCaretKey([['M-f'], ['w']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectWordNext") : goDoCommand("cmd_wordNext");
            }, 'キャレットを一単語右へ移動');

key.setCaretKey([['M-b'], ['W']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectWordPrevious") : goDoCommand("cmd_wordPrevious");
            }, 'キャレットを一単語左へ移動');

key.setCaretKey([['C-v'], ['SPC']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectPageNext") : goDoCommand("cmd_movePageDown");
            }, 'キャレットを一画面分下へ');

key.setCaretKey([['M-v'], ['b']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectPagePrevious") : goDoCommand("cmd_movePageUp");
            }, 'キャレットを一画面分上へ');

key.setCaretKey([['M-<'], ['g']], function (ev) {
                ev.target.ksMarked ? goDoCommand("cmd_selectTop") : goDoCommand("cmd_scrollTop");
            }, 'キャレットをページ先頭へ移動');

key.setCaretKey('J', function (ev) {
                util.getSelectionController().scrollLine(true);
            }, '画面を一行分下へスクロール');

key.setCaretKey('K', function (ev) {
                util.getSelectionController().scrollLine(false);
            }, '画面を一行分上へスクロール');

key.setCaretKey(',', function (ev) {
                util.getSelectionController().scrollHorizontal(true);
                goDoCommand("cmd_scrollLeft");
            }, '左へスクロール');

key.setCaretKey('.', function (ev) {
                goDoCommand("cmd_scrollRight");
                    util.getSelectionController().scrollHorizontal(false);
            }, '右へスクロール');

key.setCaretKey('z', function (ev) {
                command.recenter(ev);
            }, 'キャレットの位置までスクロール');

key.setCaretKey([['C-`'], ['C-@']], function (ev) {
                command.setMark(ev);
            }, 'マークをセット', true);

key.setCaretKey(':', function (ev, arg) {
                shell.input(null, arg);
            }, 'コマンドの実行', true);

key.setCaretKey(['C-c', 'C-r'], function (ev) {
                BrowserReload();
            }, '更新', true);

key.setCaretKey(['C-c', 'C-n'], function (ev) {
                BrowserBack();
            }, '戻る');

key.setCaretKey(['C-c', 'C-p'], function (ev) {
                BrowserForward();
            }, '進む');

key.setCaretKey('f', function (ev) {
                command.focusElement(command.elementsRetrieverTextarea, 0);
            }, '最初のインプットエリアへフォーカス', true);

key.setCaretKey(['C-x', 'h'], function (ev) {
                goDoCommand("cmd_selectAll");
            }, 'すべて選択', true);

key.setCaretKey('M-n', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, true, true);
            }, '次のボタンへフォーカスを当てる');

key.setCaretKey('M-p', function (ev) {
                command.walkInputElement(command.elementsRetrieverButton, false, true);
            }, '前のボタンへフォーカスを当てる');

key.setCaretKey('j', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLineNext") : goDoCommand("cmd_scrollLineDown");
}, 'キャレットを一行下へ');

key.setCaretKey('k', function (ev) {
    ev.target.ksMarked ? goDoCommand("cmd_selectLinePrevious") : goDoCommand("cmd_scrollLineUp");
}, 'キャレットを一行上へ');
