.class public final Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;
.super Ljava/lang/Object;
.source "OssUtil.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000<\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0002\n\u0000\n\u0002\u0018\u0002\n\u0002\u0008\u0002\n\u0002\u0018\u0002\n\u0002\u0010\u0008\n\u0000\n\u0002\u0018\u0002\n\u0002\u0010\t\n\u0000\n\u0002\u0010\u000b\n\u0002\u0008\u0002\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J_\u0010\u0005\u001a\u00020\u00062\u0006\u0010\u0007\u001a\u00020\u00082\u0006\u0010\t\u001a\u00020\u00042\u0012\u0010\n\u001a\u000e\u0012\u0004\u0012\u00020\u000c\u0012\u0004\u0012\u00020\u00060\u000b2\u001e\u0010\r\u001a\u001a\u0012\u0004\u0012\u00020\u000f\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u0004\u0012\u0004\u0012\u00020\u00060\u000e2\u0008\u0008\u0002\u0010\u0010\u001a\u00020\u0011H\u0086@\u00f8\u0001\u0000\u00a2\u0006\u0002\u0010\u0012R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082D\u00a2\u0006\u0002\n\u0000\u0082\u0002\u0004\n\u0002\u0008\u0019\u00a8\u0006\u0013"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;",
        "",
        "()V",
        "TAG",
        "",
        "ossUpload",
        "",
        "ossinfo",
        "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
        "filePath",
        "onProgress",
        "Lkotlin/Function1;",
        "",
        "onUpload",
        "Lkotlin/Function3;",
        "",
        "isLog",
        "",
        "(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function3;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;

.field private static final TAG:Ljava/lang/String;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->INSTANCE:Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;

    .line 29
    const-string v0, "OssUtil"

    sput-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->TAG:Ljava/lang/String;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public static final synthetic access$getTAG$p()Ljava/lang/String;
    .locals 1

    .line 28
    sget-object v0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->TAG:Ljava/lang/String;

    return-object v0
.end method

.method public static synthetic ossUpload$default(Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function3;ZLkotlin/coroutines/Continuation;ILjava/lang/Object;)Ljava/lang/Object;
    .locals 7

    .line 30
    and-int/lit8 p7, p7, 0x10

    if-eqz p7, :cond_0

    .line 33
    const/4 p5, 0x0

    move v5, p5

    goto :goto_0

    .line 30
    :cond_0
    move v5, p5

    :goto_0
    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v3, p3

    move-object v4, p4

    move-object v6, p6

    invoke-virtual/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->ossUpload(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function3;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object p0

    return-object p0
.end method


# virtual methods
.method public final ossUpload(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function3;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 9
    .param p1, "ossinfo"    # Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;
    .param p2, "filePath"    # Ljava/lang/String;
    .param p3, "onProgress"    # Lkotlin/jvm/functions/Function1;
    .param p4, "onUpload"    # Lkotlin/jvm/functions/Function3;
    .param p5, "isLog"    # Z
    .param p6, "$completion"    # Lkotlin/coroutines/Continuation;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            "Ljava/lang/String;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function3<",
            "-",
            "Ljava/lang/Long;",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;Z",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    .line 34
    invoke-static {}, Lkotlinx/coroutines/Dispatchers;->getIO()Lkotlinx/coroutines/CoroutineDispatcher;

    move-result-object v0

    check-cast v0, Lkotlin/coroutines/CoroutineContext;

    new-instance v8, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;

    const/4 v7, 0x0

    move-object v1, v8

    move-object v2, p2

    move v3, p5

    move-object v4, p1

    move-object v5, p4

    move-object v6, p3

    invoke-direct/range {v1 .. v7}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;-><init>(Ljava/lang/String;ZLcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v8, Lkotlin/jvm/functions/Function2;

    invoke-static {v0, v8, p6}, Lkotlinx/coroutines/BuildersKt;->withContext(Lkotlin/coroutines/CoroutineContext;Lkotlin/jvm/functions/Function2;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    move-result-object v1

    if-ne v0, v1, :cond_0

    return-object v0

    :cond_0
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    .line 167
    return-object v0
.end method
