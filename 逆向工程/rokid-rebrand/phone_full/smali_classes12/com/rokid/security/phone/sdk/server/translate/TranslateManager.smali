.class public final Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;
.super Ljava/lang/Object;
.source "TranslateManager.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000;\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0003\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0010\u000b\n\u0002\u0008\u0002\n\u0002\u0008\u0004\n\u0002\u0010\u0002\n\u0002\u0008\u0007\n\u0002\u0010\u0012\n\u0002\u0008\u000c*\u0001\u000e\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0006\u0010\u0011\u001a\u00020\u0012J\u0006\u0010\u0013\u001a\u00020\u0004J\u0006\u0010\u0014\u001a\u00020\u0004J\u0010\u0010\u0015\u001a\u00020\u00122\u0006\u0010\u0016\u001a\u00020\u0008H\u0002J\u0006\u0010\u0017\u001a\u00020\u0012J\u0012\u0010\u0018\u001a\u00020\u00122\u0008\u0010\u0019\u001a\u0004\u0018\u00010\u001aH\u0002J\u0010\u0010\u001b\u001a\u00020\u00122\u0006\u0010\u001c\u001a\u00020\u000bH\u0002J\u0010\u0010\u001d\u001a\u00020\u00122\u0006\u0010\u001e\u001a\u00020\u0004H\u0002J\u000e\u0010\u001f\u001a\u00020\u00122\u0006\u0010 \u001a\u00020\u0004J\u0018\u0010!\u001a\u00020\u00122\u0006\u0010\"\u001a\u00020\u00042\u0008\u0008\u0002\u0010#\u001a\u00020\u000bJ\u0016\u0010$\u001a\u00020\u00122\u0006\u0010\u0010\u001a\u00020\u00042\u0006\u0010\t\u001a\u00020\u0004J\u0008\u0010%\u001a\u00020\u0012H\u0002R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000R\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u0008X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\t\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\n\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u000c\u001a\u00020\u000bX\u0082\u000e\u00a2\u0006\u0002\n\u0000R\u0010\u0010\r\u001a\u00020\u000eX\u0082\u0004\u00a2\u0006\u0004\n\u0002\u0010\u000fR\u000e\u0010\u0010\u001a\u00020\u0004X\u0082\u000e\u00a2\u0006\u0002\n\u0000\u00a8\u0006&"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;",
        "",
        "()V",
        "SAVE_DEST_KEY",
        "",
        "SAVE_SRC_KEY",
        "TAG",
        "curTranslateExtra",
        "Lcom/rokid/security/sdk/base/common/TranslateExtra;",
        "dest",
        "isAutoTranslateEnd",
        "",
        "isTranslateStart",
        "mInterMessageListener",
        "com/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1",
        "Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;",
        "src",
        "destroy",
        "",
        "getTranslateDest",
        "getTranslateSrc",
        "handleTranslate",
        "extra",
        "initTranslate",
        "onAudioStream",
        "audioData",
        "",
        "onConnectState",
        "connect",
        "onMessage",
        "msg",
        "onStartOrEnd",
        "method",
        "onTranslate",
        "text",
        "isFinal",
        "startTranslate",
        "stopTranslate",
        "sdk-server_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# static fields
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

.field private static final SAVE_DEST_KEY:Ljava/lang/String;

.field private static final SAVE_SRC_KEY:Ljava/lang/String;

.field private static final TAG:Ljava/lang/String;

.field private static curTranslateExtra:Lcom/rokid/security/sdk/base/common/TranslateExtra;

.field private static dest:Ljava/lang/String;

.field private static volatile isAutoTranslateEnd:Z

.field private static volatile isTranslateStart:Z

.field private static final mInterMessageListener:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;

.field private static src:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->INSTANCE:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;

    .line 34
    const-string v0, "TranslateManager::"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    .line 40
    const-string v0, ""

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    .line 41
    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    .line 44
    const-string/jumbo v0, "translate_src"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->SAVE_SRC_KEY:Ljava/lang/String;

    .line 45
    const-string/jumbo v0, "translate_dest"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->SAVE_DEST_KEY:Ljava/lang/String;

    .line 111
    new-instance v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 31
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static final synthetic access$onAudioStream(Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;[B)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;
    .param p1, "audioData"    # [B

    .line 31
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onAudioStream([B)V

    return-void
.end method

.method public static final synthetic access$onConnectState(Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;Z)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;
    .param p1, "connect"    # Z

    .line 31
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onConnectState(Z)V

    return-void
.end method

.method public static final synthetic access$onMessage(Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;Ljava/lang/String;)V
    .locals 0
    .param p0, "$this"    # Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;
    .param p1, "msg"    # Ljava/lang/String;

    .line 31
    invoke-direct {p0, p1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onMessage(Ljava/lang/String;)V

    return-void
.end method

.method public static final synthetic access$setTranslateStart$p(Z)V
    .locals 0
    .param p0, "<set-?>"    # Z

    .line 31
    sput-boolean p0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->isTranslateStart:Z

    return-void
.end method

.method private final handleTranslate(Lcom/rokid/security/sdk/base/common/TranslateExtra;)V
    .locals 2
    .param p1, "extra"    # Lcom/rokid/security/sdk/base/common/TranslateExtra;

    .line 175
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    .line 177
    const-string/jumbo v1, "startTranslate"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v1

    if-eqz v1, :cond_0

    .line 179
    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->getSrc()Ljava/lang/String;

    move-result-object v0

    invoke-virtual {p1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->getDest()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {p0, v0, v1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->startTranslate(Ljava/lang/String;Ljava/lang/String;)V

    goto :goto_0

    .line 182
    :cond_0
    const-string/jumbo v1, "stopTranslate"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    .line 184
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->stopTranslate()V

    .line 188
    :cond_1
    :goto_0
    return-void
.end method

.method private final onAudioStream([B)V
    .locals 2
    .param p1, "audioData"    # [B

    .line 153
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->curTranslateExtra:Lcom/rokid/security/sdk/base/common/TranslateExtra;

    if-eqz v0, :cond_0

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->getMethodName()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    :cond_0
    const/4 v0, 0x0

    :goto_0
    const-string/jumbo v1, "startTranslate"

    invoke-static {v0, v1}, Lkotlin/jvm/internal/Intrinsics;->areEqual(Ljava/lang/Object;Ljava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_1

    sget-boolean v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->isTranslateStart:Z

    if-eqz v0, :cond_1

    .line 154
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    invoke-virtual {v0, p1}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->doTranslateVoice([B)V

    .line 156
    :cond_1
    return-void
.end method

.method private final onConnectState(Z)V
    .locals 10
    .param p1, "connect"    # Z

    .line 241
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onConnectState-->"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/glasses/transport/sdk/api/utils/log/SL;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 242
    new-instance v0, Lcom/rokid/security/sdk/base/common/TtsExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/TtsExtra;-><init>()V

    .line 243
    .local v0, "extra":Lcom/rokid/security/sdk/base/common/TtsExtra;
    const-string v1, "connectState"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setMethodName(Ljava/lang/String;)V

    .line 244
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/TtsExtra;->setConnectState(Z)V

    .line 245
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 246
    .local v1, "extraStr":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string v3, "extraStr"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "TRANSLATE_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 247
    return-void
.end method

.method private final onMessage(Ljava/lang/String;)V
    .locals 5
    .param p1, "msg"    # Ljava/lang/String;

    .line 160
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "->onMessage "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 161
    move-object v0, p1

    check-cast v0, Ljava/lang/CharSequence;

    const-string v1, "TRANSLATE_API_ACTION"

    check-cast v1, Ljava/lang/CharSequence;

    const/4 v2, 0x2

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static {v0, v1, v4, v2, v3}, Lkotlin/text/StringsKt;->contains$default(Ljava/lang/CharSequence;Ljava/lang/CharSequence;ZILjava/lang/Object;)Z

    move-result v0

    if-eqz v0, :cond_0

    .line 162
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onMessage "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 163
    sget-object v0, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v0}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v0

    const-class v1, Lcom/rokid/security/sdk/base/common/RkBaseData;

    invoke-virtual {v0, p1, v1}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/sdk/base/common/RkBaseData;

    .line 164
    .local v0, "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v0}, Lcom/rokid/security/sdk/base/common/RkBaseData;->getExtra()Ljava/lang/String;

    move-result-object v2

    const-class v3, Lcom/rokid/security/sdk/base/common/TranslateExtra;

    invoke-virtual {v1, v2, v3}, Lcom/google/gson/Gson;->fromJson(Ljava/lang/String;Ljava/lang/Class;)Ljava/lang/Object;

    move-result-object v1

    check-cast v1, Lcom/rokid/security/sdk/base/common/TranslateExtra;

    .line 165
    .local v1, "mTranslateExtra":Lcom/rokid/security/sdk/base/common/TranslateExtra;
    sput-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->curTranslateExtra:Lcom/rokid/security/sdk/base/common/TranslateExtra;

    .line 166
    const-string v2, "mTranslateExtra"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-direct {p0, v1}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->handleTranslate(Lcom/rokid/security/sdk/base/common/TranslateExtra;)V

    .line 169
    .end local v0    # "rkBaseData":Lcom/rokid/security/sdk/base/common/RkBaseData;
    .end local v1    # "mTranslateExtra":Lcom/rokid/security/sdk/base/common/TranslateExtra;
    :cond_0
    return-void
.end method

.method public static synthetic onTranslate$default(Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;Ljava/lang/String;ZILjava/lang/Object;)V
    .locals 0

    .line 215
    and-int/lit8 p3, p3, 0x2

    if-eqz p3, :cond_0

    const/4 p2, 0x0

    :cond_0
    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->onTranslate(Ljava/lang/String;Z)V

    return-void
.end method

.method private final stopTranslate()V
    .locals 1

    .line 210
    const/4 v0, 0x1

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->isAutoTranslateEnd:Z

    .line 211
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    invoke-virtual {v0}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->stopTranslate()V

    .line 212
    return-void
.end method


# virtual methods
.method public final destroy()V
    .locals 2

    .line 252
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->removeInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 253
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    invoke-virtual {v0}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->destroy()V

    .line 254
    return-void
.end method

.method public final getTranslateDest()Ljava/lang/String;
    .locals 1

    .line 146
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    return-object v0
.end method

.method public final getTranslateSrc()Ljava/lang/String;
    .locals 1

    .line 141
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    return-object v0
.end method

.method public final initTranslate()V
    .locals 9

    .line 49
    sget-object v0, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->INSTANCE:Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->mInterMessageListener:Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$mInterMessageListener$1;

    check-cast v1, Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/MessageServerImpl;->addInterMessageListener(Lcom/rokid/security/phone/sdk/server/msg/InterMessageListener;)V

    .line 50
    new-instance v0, Lcom/rokid/security/sdk/ability/bean/BaseConfig;

    invoke-direct {v0}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;-><init>()V

    .line 51
    .local v0, "mBaseConfig":Lcom/rokid/security/sdk/ability/bean/BaseConfig;
    sget-object v1, Lcom/rokid/security/sdk/ability/net/UrlConfig;->INSTANCE:Lcom/rokid/security/sdk/ability/net/UrlConfig;

    invoke-virtual {v1}, Lcom/rokid/security/sdk/ability/net/UrlConfig;->getWS_TRANSLATE()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/ability/bean/BaseConfig;->setServerUrl(Ljava/lang/String;)V

    .line 53
    invoke-static {}, Lcom/blankj/utilcode/util/SPUtils;->getInstance()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->SAVE_SRC_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/blankj/utilcode/util/SPUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "getInstance().getString(SAVE_SRC_KEY)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    .line 54
    invoke-static {}, Lcom/blankj/utilcode/util/SPUtils;->getInstance()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v1

    sget-object v2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->SAVE_DEST_KEY:Ljava/lang/String;

    invoke-virtual {v1, v2}, Lcom/blankj/utilcode/util/SPUtils;->getString(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "getInstance().getString(SAVE_DEST_KEY)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    sput-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    .line 56
    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x1

    const/4 v3, 0x0

    if-nez v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v3

    :goto_0
    if-eqz v1, :cond_1

    .line 57
    const-string v1, "en"

    sput-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    .line 60
    :cond_1
    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-nez v1, :cond_2

    goto :goto_1

    :cond_2
    move v2, v3

    :goto_1
    if-eqz v2, :cond_3

    .line 61
    const-string/jumbo v1, "zh"

    sput-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    .line 63
    :cond_3
    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string v3, "initTranslate "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    sget-object v3, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 64
    sget-object v1, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$initTranslate$1;

    invoke-direct {v2}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$initTranslate$1;-><init>()V

    check-cast v2, Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;

    invoke-virtual {v1, v0, v2}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->init(Lcom/rokid/security/sdk/ability/bean/BaseConfig;Lcom/rokid/security/phone/core/ability/translate/TranslateConnectClient$TranslateListener;)V

    .line 100
    invoke-static {}, Lcom/rokid/security/phone/sdk/base/utils/other/ScopesKt;->getMainScope()Lkotlinx/coroutines/CoroutineScope;

    move-result-object v3

    new-instance v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$initTranslate$2;

    const/4 v2, 0x0

    invoke-direct {v1, v2}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager$initTranslate$2;-><init>(Lkotlin/coroutines/Continuation;)V

    move-object v6, v1

    check-cast v6, Lkotlin/jvm/functions/Function2;

    const/4 v7, 0x3

    const/4 v8, 0x0

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v3 .. v8}, Lkotlinx/coroutines/BuildersKt;->launch$default(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/CoroutineContext;Lkotlinx/coroutines/CoroutineStart;Lkotlin/jvm/functions/Function2;ILjava/lang/Object;)Lkotlinx/coroutines/Job;

    .line 107
    return-void
.end method

.method public final onStartOrEnd(Ljava/lang/String;)V
    .locals 10
    .param p1, "method"    # Ljava/lang/String;

    const-string v0, "method"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 232
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onStartOrEnd "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 233
    new-instance v0, Lcom/rokid/security/sdk/base/common/TranslateExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/TranslateExtra;-><init>()V

    .line 234
    .local v0, "translateExtra":Lcom/rokid/security/sdk/base/common/TranslateExtra;
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->setMethodName(Ljava/lang/String;)V

    .line 235
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 236
    .local v1, "str":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string/jumbo v3, "str"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "TRANSLATE_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 237
    return-void
.end method

.method public final onTranslate(Ljava/lang/String;Z)V
    .locals 10
    .param p1, "text"    # Ljava/lang/String;
    .param p2, "isFinal"    # Z

    const-string/jumbo v0, "text"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 217
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string v2, "onTranslate "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, " isFinal:"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Z)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 218
    new-instance v0, Lcom/rokid/security/sdk/base/common/TranslateExtra;

    invoke-direct {v0}, Lcom/rokid/security/sdk/base/common/TranslateExtra;-><init>()V

    .line 219
    .local v0, "translateExtra":Lcom/rokid/security/sdk/base/common/TranslateExtra;
    if-eqz p2, :cond_0

    .line 220
    const-string v1, "onFinalTranslate"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->setMethodName(Ljava/lang/String;)V

    goto :goto_0

    .line 222
    :cond_0
    const-string v1, "onTranslate"

    invoke-virtual {v0, v1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->setMethodName(Ljava/lang/String;)V

    .line 224
    :goto_0
    invoke-virtual {v0, p1}, Lcom/rokid/security/sdk/base/common/TranslateExtra;->setText(Ljava/lang/String;)V

    .line 225
    sget-object v1, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    invoke-virtual {v1}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->getMGson()Lcom/google/gson/Gson;

    move-result-object v1

    invoke-virtual {v1, v0}, Lcom/google/gson/Gson;->toJson(Ljava/lang/Object;)Ljava/lang/String;

    move-result-object v1

    .line 226
    .local v1, "str":Ljava/lang/String;
    sget-object v2, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->INSTANCE:Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;

    const-string/jumbo v3, "str"

    invoke-static {v1, v3}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    const/16 v8, 0x1c

    const/4 v9, 0x0

    const-string v3, "TRANSLATE_API_ACTION"

    const/4 v5, 0x0

    const/4 v6, 0x0

    const/4 v7, 0x0

    move-object v4, v1

    invoke-static/range {v2 .. v9}, Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;->sendNormalData$default(Lcom/rokid/security/phone/sdk/server/dataHandler/SenderHandler;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;ILjava/lang/Object;)V

    .line 227
    return-void
.end method

.method public final startTranslate(Ljava/lang/String;Ljava/lang/String;)V
    .locals 4
    .param p1, "src"    # Ljava/lang/String;
    .param p2, "dest"    # Ljava/lang/String;

    const-string/jumbo v0, "src"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    const-string v0, "dest"

    invoke-static {p2, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 192
    invoke-direct {p0}, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->stopTranslate()V

    .line 193
    const/4 v0, 0x0

    sput-boolean v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->isAutoTranslateEnd:Z

    .line 194
    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v3, "startTranslate "

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    const/16 v3, 0x20

    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 195
    move-object v1, p1

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    const/4 v2, 0x1

    if-lez v1, :cond_0

    move v1, v2

    goto :goto_0

    :cond_0
    move v1, v0

    :goto_0
    if-eqz v1, :cond_2

    move-object v1, p2

    check-cast v1, Ljava/lang/CharSequence;

    invoke-interface {v1}, Ljava/lang/CharSequence;->length()I

    move-result v1

    if-lez v1, :cond_1

    move v0, v2

    :cond_1
    if-eqz v0, :cond_2

    .line 196
    sput-object p1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    .line 197
    sput-object p2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    .line 199
    :cond_2
    invoke-static {}, Lcom/blankj/utilcode/util/SPUtils;->getInstance()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->SAVE_SRC_KEY:Ljava/lang/String;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/blankj/utilcode/util/SPUtils;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 200
    invoke-static {}, Lcom/blankj/utilcode/util/SPUtils;->getInstance()Lcom/blankj/utilcode/util/SPUtils;

    move-result-object v0

    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->SAVE_DEST_KEY:Ljava/lang/String;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/blankj/utilcode/util/SPUtils;->put(Ljava/lang/String;Ljava/lang/String;)V

    .line 202
    sget-object v0, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->TAG:Ljava/lang/String;

    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v2, "startTranslate-> "

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v3}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, p2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 203
    sget-object v0, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->INSTANCE:Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;

    sget-object v1, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->src:Ljava/lang/String;

    sget-object v2, Lcom/rokid/security/phone/sdk/server/translate/TranslateManager;->dest:Ljava/lang/String;

    invoke-virtual {v0, v1, v2}, Lcom/rokid/security/phone/core/ability/translate/TranslateEngine;->startTranslate(Ljava/lang/String;Ljava/lang/String;)V

    .line 204
    return-void
.end method
