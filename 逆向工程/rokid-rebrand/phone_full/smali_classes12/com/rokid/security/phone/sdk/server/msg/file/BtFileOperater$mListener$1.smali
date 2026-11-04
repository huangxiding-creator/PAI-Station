.class public final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;
.super Ljava/lang/Object;
.source "BtFileOperater.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBtFileOperater.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BtFileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,362:1\n1855#2,2:363\n1855#2,2:365\n1855#2,2:367\n1855#2,2:369\n1855#2,2:371\n1855#2,2:373\n1855#2,2:375\n1855#2,2:377\n1855#2,2:379\n1855#2,2:381\n*S KotlinDebug\n*F\n+ 1 BtFileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1\n*L\n189#1:363,2\n190#1:365,2\n195#1:367,2\n196#1:369,2\n201#1:371,2\n202#1:373,2\n207#1:375,2\n208#1:377,2\n213#1:379,2\n214#1:381,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u000c\u001a\u00020\u0003H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1",
        "Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;",
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
        "onStartNotify",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    .line 183
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 7
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 206
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    const/4 v5, 0x6

    const/4 v6, 0x0

    const-string v2, "cancel_receive_file"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 207
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 375
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    const/4 v5, 0x0

    .line 207
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onCancel$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onCancel()V

    .line 375
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onCancel$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 376
    :cond_0
    nop

    .line 208
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 377
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    const/4 v5, 0x0

    .line 208
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onCancel$2":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onCancel(Ljava/lang/String;)V

    .line 377
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onCancel$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 378
    :cond_1
    nop

    .line 209
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 8
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 200
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    const/4 v5, 0x2

    const/4 v6, 0x0

    const-string v2, "receive_file_complete"

    const/4 v3, 0x0

    move-object v4, p1

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 201
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 371
    .local v1, "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_0
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    const-string v4, ""

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .local v3, "element$iv":Ljava/lang/Object;
    move-object v5, v3

    check-cast v5, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    const/4 v6, 0x0

    .line 201
    .local v6, "$i$a$-forEach-BtFileOperater$mListener$1$onComplete$1":I
    if-nez p1, :cond_0

    goto :goto_1

    :cond_0
    move-object v4, p1

    :goto_1
    invoke-interface {v5, v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 371
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v6    # "$i$a$-forEach-BtFileOperater$mListener$1$onComplete$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 372
    :cond_1
    nop

    .line 202
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 373
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_2
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_3

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v5, v3

    check-cast v5, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    .local v5, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    const/4 v6, 0x0

    .line 202
    .local v6, "$i$a$-forEach-BtFileOperater$mListener$1$onComplete$2":I
    if-nez p1, :cond_2

    move-object v7, v4

    goto :goto_3

    :cond_2
    move-object v7, p1

    :goto_3
    invoke-interface {v5, v7}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onComplete(Ljava/lang/String;)V

    .line 373
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v6    # "$i$a$-forEach-BtFileOperater$mListener$1$onComplete$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 374
    :cond_3
    nop

    .line 203
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onFail()V
    .locals 6

    .line 212
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    const/4 v4, 0x6

    const/4 v5, 0x0

    const-string v1, "receive_file_fail"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 213
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 379
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    const/4 v5, 0x0

    .line 213
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onFail$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onFail()V

    .line 379
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onFail$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 380
    :cond_0
    nop

    .line 214
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 381
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    const/4 v5, 0x0

    .line 214
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onFail$2":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onFail()V

    .line 381
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onFail$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 382
    :cond_1
    nop

    .line 215
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onProgressChanged(Ljava/lang/String;F)V
    .locals 7
    .param p1, "filePath"    # Ljava/lang/String;
    .param p2, "progress"    # F

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 194
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const-string v2, "receive_progress_file"

    const/4 v4, 0x0

    move v3, p2

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 195
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 367
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    const/4 v5, 0x0

    .line 195
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onProgressChanged$1":I
    invoke-interface {v4, p2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onProgressChanged(F)V

    .line 367
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onProgressChanged$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 368
    :cond_0
    nop

    .line 196
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 369
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    const/4 v5, 0x0

    .line 196
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onProgressChanged$2":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onProgressChanged(Ljava/lang/String;F)V

    .line 369
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onProgressChanged$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 370
    :cond_1
    nop

    .line 197
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 189
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 363
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

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    const/4 v5, 0x0

    .line 189
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onStart$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onStart()V

    .line 363
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onStart$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 364
    :cond_0
    nop

    .line 190
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 365
    .restart local v1    # "$i$f$forEach":I
    invoke-interface {v0}, Ljava/lang/Iterable;->iterator()Ljava/util/Iterator;

    move-result-object v2

    :goto_1
    invoke-interface {v2}, Ljava/util/Iterator;->hasNext()Z

    move-result v3

    if-eqz v3, :cond_1

    invoke-interface {v2}, Ljava/util/Iterator;->next()Ljava/lang/Object;

    move-result-object v3

    .restart local v3    # "element$iv":Ljava/lang/Object;
    move-object v4, v3

    check-cast v4, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;

    .local v4, "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    const/4 v5, 0x0

    .line 190
    .local v5, "$i$a$-forEach-BtFileOperater$mListener$1$onStart$2":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onStart(Ljava/lang/String;)V

    .line 365
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-BtFileOperater$mListener$1$onStart$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 366
    :cond_1
    nop

    .line 191
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStartNotify()V
    .locals 6

    .line 185
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;

    const/4 v4, 0x6

    const/4 v5, 0x0

    const-string/jumbo v1, "start_receive_file"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/BtFileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 186
    return-void
.end method
