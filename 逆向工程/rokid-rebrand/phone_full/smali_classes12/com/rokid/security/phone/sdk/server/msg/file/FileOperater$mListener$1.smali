.class public final Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;
.super Ljava/lang/Object;
.source "FileOperater.kt"

# interfaces
.implements Lcom/rokid/security/phone/sdk/server/msg/file/FileReceiveListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;-><init>()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x19
    name = null
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFileOperater.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1\n+ 2 _Collections.kt\nkotlin/collections/CollectionsKt___CollectionsKt\n*L\n1#1,322:1\n1855#2,2:323\n1855#2,2:325\n1855#2,2:327\n1855#2,2:329\n1855#2,2:331\n1855#2,2:333\n1855#2,2:335\n1855#2,2:337\n1855#2,2:339\n1855#2,2:341\n*S KotlinDebug\n*F\n+ 1 FileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1\n*L\n129#1:323,2\n130#1:325,2\n135#1:327,2\n136#1:329,2\n141#1:331,2\n142#1:333,2\n147#1:335,2\n148#1:337,2\n153#1:339,2\n154#1:341,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000!\n\u0000\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0010\u0007\n\u0002\u0008\u0003*\u0001\u0000\u0008\n\u0018\u00002\u00020\u0001J\u0010\u0010\u0002\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0010\u0010\u0006\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u0007\u001a\u00020\u0003H\u0016J\u0018\u0010\u0008\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u00052\u0006\u0010\t\u001a\u00020\nH\u0016J\u0010\u0010\u000b\u001a\u00020\u00032\u0006\u0010\u0004\u001a\u00020\u0005H\u0016J\u0008\u0010\u000c\u001a\u00020\u0003H\u0016\u00a8\u0006\r"
    }
    d2 = {
        "com/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1",
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
.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)V
    .locals 0
    .param p1, "$receiver"    # Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    .line 123
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public onCancel(Ljava/lang/String;)V
    .locals 7
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 146
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v5, 0x6

    const/4 v6, 0x0

    const-string v2, "cancel_receive_file"

    const/4 v3, 0x0

    const/4 v4, 0x0

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 147
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 335
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

    .line 147
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onCancel$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onCancel()V

    .line 335
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onCancel$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 336
    :cond_0
    nop

    .line 148
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 337
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

    .line 148
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onCancel$2":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onCancel(Ljava/lang/String;)V

    .line 337
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onCancel$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 338
    :cond_1
    nop

    .line 149
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onComplete(Ljava/lang/String;)V
    .locals 8
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 140
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v5, 0x2

    const/4 v6, 0x0

    const-string v2, "receive_file_complete"

    const/4 v3, 0x0

    move-object v4, p1

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 141
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 331
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

    .line 141
    .local v6, "$i$a$-forEach-FileOperater$mListener$1$onComplete$1":I
    if-nez p1, :cond_0

    goto :goto_1

    :cond_0
    move-object v4, p1

    :goto_1
    invoke-interface {v5, v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onComplete(Ljava/lang/String;)V

    .line 331
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v6    # "$i$a$-forEach-FileOperater$mListener$1$onComplete$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 332
    :cond_1
    nop

    .line 142
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 333
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

    .line 142
    .local v6, "$i$a$-forEach-FileOperater$mListener$1$onComplete$2":I
    if-nez p1, :cond_2

    move-object v7, v4

    goto :goto_3

    :cond_2
    move-object v7, p1

    :goto_3
    invoke-interface {v5, v7}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onComplete(Ljava/lang/String;)V

    .line 333
    .end local v5    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v6    # "$i$a$-forEach-FileOperater$mListener$1$onComplete$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_2

    .line 334
    :cond_3
    nop

    .line 143
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onFail()V
    .locals 6

    .line 152
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v4, 0x6

    const/4 v5, 0x0

    const-string v1, "receive_file_fail"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 153
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 339
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

    .line 153
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onFail$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onFail()V

    .line 339
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onFail$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 340
    :cond_0
    nop

    .line 154
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 341
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

    .line 154
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onFail$2":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onFail()V

    .line 341
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onFail$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 342
    :cond_1
    nop

    .line 155
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

    .line 134
    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v5, 0x4

    const/4 v6, 0x0

    const-string v2, "receive_progress_file"

    const/4 v4, 0x0

    move v3, p2

    invoke-static/range {v1 .. v6}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 135
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 327
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

    .line 135
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onProgressChanged$1":I
    invoke-interface {v4, p2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onProgressChanged(F)V

    .line 327
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onProgressChanged$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 328
    :cond_0
    nop

    .line 136
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 329
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

    .line 136
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onProgressChanged$2":I
    invoke-interface {v4, p1, p2}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onProgressChanged(Ljava/lang/String;F)V

    .line 329
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onProgressChanged$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 330
    :cond_1
    nop

    .line 137
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStart(Ljava/lang/String;)V
    .locals 6
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 129
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveListeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .local v0, "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 323
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

    .line 129
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onStart$1":I
    invoke-interface {v4}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onStart()V

    .line 323
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onStart$1":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_0

    .line 324
    :cond_0
    nop

    .line 130
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getMFileReceiveV2Listeners$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/util/Set;

    move-result-object v0

    check-cast v0, Ljava/lang/Iterable;

    .restart local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    const/4 v1, 0x0

    .line 325
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

    .line 130
    .local v5, "$i$a$-forEach-FileOperater$mListener$1$onStart$2":I
    invoke-interface {v4, p1}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;->onStart(Ljava/lang/String;)V

    .line 325
    .end local v4    # "it":Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveV2Listener;
    .end local v5    # "$i$a$-forEach-FileOperater$mListener$1$onStart$2":I
    nop

    .end local v3    # "element$iv":Ljava/lang/Object;
    goto :goto_1

    .line 326
    :cond_1
    nop

    .line 131
    .end local v0    # "$this$forEach$iv":Ljava/lang/Iterable;
    .end local v1    # "$i$f$forEach":I
    return-void
.end method

.method public onStartNotify()V
    .locals 6

    .line 125
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$mListener$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v4, 0x6

    const/4 v5, 0x0

    const-string/jumbo v1, "start_receive_file"

    const/4 v2, 0x0

    const/4 v3, 0x0

    invoke-static/range {v0 .. v5}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    .line 126
    return-void
.end method
