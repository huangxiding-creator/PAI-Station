.class final Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;
.super Lkotlin/jvm/internal/Lambda;
.source "FileOperater.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function1;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1;->invoke(Z)V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function1<",
        "Ljava/lang/Boolean;",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nFileOperater.kt\nKotlin\n*S Kotlin\n*F\n+ 1 FileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,322:1\n93#2:323\n*S KotlinDebug\n*F\n+ 1 FileOperater.kt\ncom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1\n*L\n194#1:323\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0010\u000b\n\u0000\u0010\u0000\u001a\u00020\u00012\u0006\u0010\u0002\u001a\u00020\u0003H\n\u00a2\u0006\u0002\u0008\u0004"
    }
    d2 = {
        "<anonymous>",
        "",
        "it",
        "",
        "invoke"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation


# instance fields
.field final synthetic $dir:Ljava/lang/String;

.field final synthetic $file:Ljava/io/File;

.field final synthetic $listener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

.field final synthetic $onResult:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/io/File;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;Ljava/lang/String;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;",
            "Ljava/io/File;",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;",
            "Ljava/lang/String;",
            ")V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$file:Ljava/io/File;

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$listener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$onResult:Lkotlin/jvm/functions/Function1;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$dir:Ljava/lang/String;

    const/4 v0, 0x1

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1
    .param p1, "p1"    # Ljava/lang/Object;

    .line 185
    move-object v0, p1

    check-cast v0, Ljava/lang/Boolean;

    invoke-virtual {v0}, Ljava/lang/Boolean;->booleanValue()Z

    move-result v0

    invoke-virtual {p0, v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->invoke(Z)V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke(Z)V
    .locals 9
    .param p1, "it"    # Z

    .line 186
    if-eqz p1, :cond_0

    .line 187
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$file:Ljava/io/File;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$setFile$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/io/File;)V

    .line 188
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$listener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$setMFileReceiveListener$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;)V

    .line 189
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$onResult:Lkotlin/jvm/functions/Function1;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$setOnResultFun$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Lkotlin/jvm/functions/Function1;)V

    .line 190
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$dir:Ljava/lang/String;

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$setDir$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;)V

    .line 191
    iget-object v2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    const/4 v6, 0x6

    const/4 v7, 0x0

    const-string v3, "ready_receive_file"

    const/4 v4, 0x0

    const/4 v5, 0x0

    invoke-static/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->sendMsg$default(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;Ljava/lang/String;FLjava/lang/String;ILjava/lang/Object;)V

    goto :goto_0

    .line 193
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->this$0:Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;

    invoke-static {v0}, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;->access$getTAG$p(Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater;)Ljava/lang/String;

    move-result-object v0

    const-string v1, " sendFile:  P2P connect fail"

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v0, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 194
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/FileOperater$sendFile$1$1;->$onResult:Lkotlin/jvm/functions/Function1;

    sget-object v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v8, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v6, 0x4

    const/4 v7, 0x0

    const/4 v3, -0x2

    const-string v4, "P2P not connect"

    const/4 v5, 0x0

    move-object v2, v8

    invoke-direct/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v2, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v3, 0x0

    .line 323
    .local v3, "$i$f$failure":I
    invoke-static {v2}, Lcom/rokid/security/phone/sdk/base/data/callback/IResultKt;->createFailure(Lcom/rokid/security/phone/sdk/base/data/callback/IException;)Ljava/lang/Object;

    move-result-object v4

    invoke-static {v4}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->constructor-impl(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v1

    .end local v1    # "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    .end local v2    # "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    .end local v3    # "$i$f$failure":I
    invoke-static {v1}, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->box-impl(Ljava/lang/Object;)Lcom/rokid/security/phone/sdk/base/data/callback/IResult;

    move-result-object v1

    .line 194
    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 196
    :goto_0
    return-void
.end method
