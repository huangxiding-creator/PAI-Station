.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1;
.super Ljava/lang/Object;
.source "ClassicBlueToothServiceImpl.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBlueToothServiceImpl.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBlueToothServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,292:1\n1855#2,2:293\n1855#2,2:295\n1855#2,2:297\n1855#2,2:299\n1855#2,2:301\n*S KotlinDebug\n*F\n+ 1 ClassicBlueToothServiceImpl.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1\n*L\n261#1:293,2\n267#1:295,2\n273#1:297,2\n279#1:299,2\n285#1:301,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl$mFileReceiveListener$1",
        "Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;",
        "onCancel",
        "",
        "filePath",
        "",
        "onComplete",
        "onFail",
        "onProgressChanged",
        "progress",
        "",
        "onStart",
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


# direct methods
.method constructor <init>()V
    .locals 0

    .line 258
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 261
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMFileReceiveListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 293
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    const/4 v5, 0x0

    .line 262
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onCancel$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onCancel(Ljava/lang/String;)V

    .line 263
    nop

    .line 293
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onCancel$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 294
    :cond_0
    nop

    .line 264
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 267
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMFileReceiveListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 295
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    const/4 v5, 0x0

    .line 268
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onComplete$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 269
    nop

    .line 295
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onComplete$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 296
    :cond_0
    nop

    .line 270
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onFail()V
    .locals 6

    .line 273
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMFileReceiveListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 297
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    const/4 v5, 0x0

    .line 274
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onFail$1":I
    invoke-interface {v4}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onFail()V

    .line 275
    nop

    .line 297
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onFail$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 298
    :cond_0
    nop

    .line 276
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onProgressChanged(Ljava/lang/String;F)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 279
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMFileReceiveListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 299
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    const/4 v5, 0x0

    .line 280
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onProgressChanged$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onProgressChanged(Ljava/lang/String;F)V

    .line 281
    nop

    .line 299
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onProgressChanged$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 300
    :cond_0
    nop

    .line 282
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 285
    invoke-static {}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/server/ClassicBlueToothServiceImpl;->access$getMFileReceiveListeners$p()Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 301
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_0

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;

    .local v4, "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    const/4 v5, 0x0

    .line 286
    .local v5, "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onStart$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onStart(Ljava/lang/String;)V

    .line 287
    nop

    .line 301
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothServiceImpl$mFileReceiveListener$1$onStart$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 302
    :cond_0
    nop

    .line 288
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method
