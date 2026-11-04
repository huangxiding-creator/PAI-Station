.class public interface abstract Lcom/rokid/security/phone/sdk/server/net/OssApiService;
.super Ljava/lang/Object;
.source "OssApiService.kt"


# annotations
.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lcom/rokid/security/phone/sdk/server/net/OssApiService$Companion;,
        Lcom/rokid/security/phone/sdk/server/net/OssApiService$Headers;
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000.\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0000\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u000e\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0003\u0008f\u0018\u0000 \r2\u00020\u0001:\u0002\r\u000eJ\u001e\u0010\u0002\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00050\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u0007H\'J\u001e\u0010\u0008\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\u00050\u00040\u00032\u0008\u0008\u0001\u0010\u0006\u001a\u00020\u0007H\'J\u001e\u0010\t\u001a\u000e\u0012\n\u0012\u0008\u0012\u0004\u0012\u00020\n0\u00040\u00032\u0008\u0008\u0001\u0010\u000b\u001a\u00020\u000cH\'\u00a8\u0006\u000f"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/net/OssApiService;",
        "",
        "getStsToken",
        "Lkotlinx/coroutines/flow/Flow;",
        "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2;",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
        "category",
        "",
        "getStsTokenBySn",
        "saveFileInfo",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
        "param",
        "Lcom/rokid/security/phone/sdk/server/recog/online/param/OssFileParam;",
        "Companion",
        "Headers",
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
.field public static final Companion:Lcom/rokid/security/phone/sdk/server/net/OssApiService$Companion;

.field public static final TOKEN:Ljava/lang/String; = "Authorization"


# direct methods
.method static constructor <clinit>()V
    .locals 1

    sget-object v0, Lcom/rokid/security/phone/sdk/server/net/OssApiService$Companion;->$$INSTANCE:Lcom/rokid/security/phone/sdk/server/net/OssApiService$Companion;

    sput-object v0, Lcom/rokid/security/phone/sdk/server/net/OssApiService;->Companion:Lcom/rokid/security/phone/sdk/server/net/OssApiService$Companion;

    return-void
.end method


# virtual methods
.method public abstract getStsToken(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Query;
            value = "category"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/file/api/v1/stsToken"
    .end annotation
.end method

.method public abstract getStsTokenBySn(Ljava/lang/String;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Ljava/lang/String;
        .annotation runtime Lretrofit2/http/Query;
            value = "category"
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/file/api/v1/stsTokenBySn"
    .end annotation
.end method

.method public abstract saveFileInfo(Lcom/rokid/security/phone/sdk/server/recog/online/param/OssFileParam;)Lkotlinx/coroutines/flow/Flow;
    .param p1    # Lcom/rokid/security/phone/sdk/server/recog/online/param/OssFileParam;
        .annotation runtime Lretrofit2/http/Body;
        .end annotation
    .end param
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/recog/online/param/OssFileParam;",
            ")",
            "Lkotlinx/coroutines/flow/Flow<",
            "Lcom/rokid/security/phone/sdk/base/utils/net/bean/BaseResponse2<",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/FileSavedInfo;",
            ">;>;"
        }
    .end annotation

    .annotation runtime Lretrofit2/http/POST;
        value = "/ar/file/api/v1/save"
    .end annotation
.end method
