.class public final Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;
.super Ljava/lang/Object;
.source "ClassicBlueToothClientManager.kt"

# interfaces
.implements Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nClassicBlueToothClientManager.kt\nKotlin\n*S Kotlin\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,1451:1\n1855#2,2:1452\n1855#2,2:1454\n1855#2,2:1456\n1855#2,2:1458\n1855#2,2:1460\n*S KotlinDebug\n*F\n+ 1 ClassicBlueToothClientManager.kt\ncom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1\n*L\n1420#1:1452,2\n1426#1:1454,2\n1432#1:1456,2\n1438#1:1458,2\n1444#1:1460,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0002*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016\u00a8\u0006\u000c"
    }
    d2 = {
        "com/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1",
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


# instance fields
.field final synthetic this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;


# direct methods
.method constructor <init>(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    iput-object p1, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    .line 1417
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1420
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1452
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

    .line 1421
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onCancel$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onCancel(Ljava/lang/String;)V

    .line 1422
    nop

    .line 1452
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onCancel$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1453
    :cond_0
    nop

    .line 1423
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1426
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1454
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

    .line 1427
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onComplete$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 1428
    nop

    .line 1454
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onComplete$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1455
    :cond_0
    nop

    .line 1429
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onFail()V
    .locals 6

    .line 1432
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1456
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

    .line 1433
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onFail$1":I
    invoke-interface {v4}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onFail()V

    .line 1434
    nop

    .line 1456
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onFail$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1457
    :cond_0
    nop

    .line 1435
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

    .line 1438
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1458
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

    .line 1439
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onProgressChanged$1":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onProgressChanged(Ljava/lang/String;F)V

    .line 1440
    nop

    .line 1458
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onProgressChanged$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1459
    :cond_0
    nop

    .line 1441
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 1444
    iget-object v0, p0, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager$mFileReceiveListener$1;->this$0:Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;

    invoke-static {v0}, Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;->access$getMFileReceiveListeners$p(Lcom/rokid/glasses/transport/sdk/server/bluetooth/client/ClassicBlueToothClientManager;)Ljava/util/concurrent/CopyOnWriteArrayList;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 1460
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

    .line 1445
    .local v5, "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onStart$1":I
    invoke-interface {v4, p1}, Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;->onStart(Ljava/lang/String;)V

    .line 1446
    nop

    .line 1460
    .end local v4    # "it":Lcom/rokid/glasses/transport/sdk/api/bluetooth/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-ClassicBlueToothClientManager$mFileReceiveListener$1$onStart$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 1461
    :cond_0
    nop

    .line 1447
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method
