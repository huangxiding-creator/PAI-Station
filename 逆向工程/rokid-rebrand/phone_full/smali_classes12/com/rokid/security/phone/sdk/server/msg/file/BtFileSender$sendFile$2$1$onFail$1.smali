.class final Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;
.super Lkotlin/jvm/internal/Lambda;
.source "BtFileSender.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function0;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1;->onFail()V
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/jvm/internal/Lambda;",
        "Lkotlin/jvm/functions/Function0<",
        "Lkotlin/Unit;",
        ">;"
    }
.end annotation

.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nBtFileSender.kt\nKotlin\n*S Kotlin\n*F\n+ 1 BtFileSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1\n+ 2 IResult.kt\ncom/rokid/security/phone/sdk/base/data/callback/IResult$Companion\n*L\n1#1,148:1\n93#2:149\n*S KotlinDebug\n*F\n+ 1 BtFileSender.kt\ncom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1\n*L\n99#1:149\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u0008\n\u0000\n\u0002\u0010\u0002\n\u0000\u0010\u0000\u001a\u00020\u0001H\n\u00a2\u0006\u0002\u0008\u0002"
    }
    d2 = {
        "<anonymous>",
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
.field final synthetic $appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

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


# direct methods
.method constructor <init>(Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;Lkotlin/jvm/functions/Function1;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Lcom/rokid/security/phone/sdk/base/data/callback/IResult<",
            "Ljava/lang/Boolean;",
            ">;",
            "Lkotlin/Unit;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    iput-object p2, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;->$onResult:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x0

    invoke-direct {p0, v0}, Lkotlin/jvm/internal/Lambda;-><init>(I)V

    return-void
.end method


# virtual methods
.method public bridge synthetic invoke()Ljava/lang/Object;
    .locals 1

    .line 97
    invoke-virtual {p0}, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;->invoke()V

    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v0
.end method

.method public final invoke()V
    .locals 9

    .line 98
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;->$appListener:Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;

    if-eqz v0, :cond_0

    invoke-interface {v0}, Lcom/rokid/security/phone/sdk/api/msg/listener/FileReceiveListener;->onFail()V

    .line 99
    :cond_0
    iget-object v0, p0, Lcom/rokid/security/phone/sdk/server/msg/file/BtFileSender$sendFile$2$1$onFail$1;->$onResult:Lkotlin/jvm/functions/Function1;

    sget-object v1, Lcom/rokid/security/phone/sdk/base/data/callback/IResult;->Companion:Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;

    .local v1, "this_$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IResult$Companion;
    new-instance v8, Lcom/rokid/security/phone/sdk/base/data/callback/IException;

    const/4 v6, 0x4

    const/4 v7, 0x0

    const/4 v3, -0x1

    const-string/jumbo v4, "\u53d1\u9001\u5931\u8d25"

    const/4 v5, 0x0

    move-object v2, v8

    invoke-direct/range {v2 .. v7}, Lcom/rokid/security/phone/sdk/base/data/callback/IException;-><init>(ILjava/lang/String;Ljava/lang/Throwable;ILkotlin/jvm/internal/DefaultConstructorMarker;)V

    .local v2, "exception$iv":Lcom/rokid/security/phone/sdk/base/data/callback/IException;
    const/4 v3, 0x0

    .line 149
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

    .line 99
    invoke-interface {v0, v1}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 100
    return-void
.end method
