.class final Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;
.super Lkotlin/coroutines/jvm/internal/SuspendLambda;
.source "OssUtil.kt"

# interfaces
.implements Lkotlin/jvm/functions/Function2;


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->ossUpload(Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Ljava/lang/String;Lkotlin/jvm/functions/Function1;Lkotlin/jvm/functions/Function3;ZLkotlin/coroutines/Continuation;)Ljava/lang/Object;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x18
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lkotlin/coroutines/jvm/internal/SuspendLambda;",
        "Lkotlin/jvm/functions/Function2<",
        "Lkotlinx/coroutines/CoroutineScope;",
        "Lkotlin/coroutines/Continuation<",
        "-",
        "Lkotlin/Unit;",
        ">;",
        "Ljava/lang/Object;",
        ">;"
    }
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\n\n\u0000\n\u0002\u0010\u0002\n\u0002\u0018\u0002\u0010\u0000\u001a\u00020\u0001*\u00020\u0002H\u008a@"
    }
    d2 = {
        "<anonymous>",
        "",
        "Lkotlinx/coroutines/CoroutineScope;"
    }
    k = 0x3
    mv = {
        0x1,
        0x8,
        0x0
    }
    xi = 0x30
.end annotation

.annotation runtime Lkotlin/coroutines/jvm/internal/DebugMetadata;
    c = "com.rokid.security.phone.sdk.server.filesystem.OssUtil$ossUpload$2"
    f = "OssUtil.kt"
    i = {}
    l = {}
    m = "invokeSuspend"
    n = {}
    s = {}
.end annotation


# instance fields
.field final synthetic $filePath:Ljava/lang/String;

.field final synthetic $isLog:Z

.field final synthetic $onProgress:Lkotlin/jvm/functions/Function1;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function1<",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $onUpload:Lkotlin/jvm/functions/Function3;
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "Lkotlin/jvm/functions/Function3<",
            "Ljava/lang/Long;",
            "Ljava/lang/String;",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation
.end field

.field final synthetic $ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

.field label:I


# direct methods
.method public static synthetic $r8$lambda$k-XGbA0PKuVRISvp-b3zOKj7Fkk(JLkotlin/jvm/functions/Function1;Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;JJ)V
    .locals 0

    invoke-static/range {p0 .. p7}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->invokeSuspend$lambda$0(JLkotlin/jvm/functions/Function1;Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;JJ)V

    return-void
.end method

.method constructor <init>(Ljava/lang/String;ZLcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/String;",
            "Z",
            "Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;",
            "Lkotlin/jvm/functions/Function3<",
            "-",
            "Ljava/lang/Long;",
            "-",
            "Ljava/lang/String;",
            "-",
            "Ljava/lang/String;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/jvm/functions/Function1<",
            "-",
            "Ljava/lang/Integer;",
            "Lkotlin/Unit;",
            ">;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;",
            ">;)V"
        }
    .end annotation

    iput-object p1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    iput-boolean p2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$isLog:Z

    iput-object p3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iput-object p4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$onUpload:Lkotlin/jvm/functions/Function3;

    iput-object p5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$onProgress:Lkotlin/jvm/functions/Function1;

    const/4 v0, 0x2

    invoke-direct {p0, v0, p6}, Lkotlin/coroutines/jvm/internal/SuspendLambda;-><init>(ILkotlin/coroutines/Continuation;)V

    return-void
.end method

.method private static final invokeSuspend$lambda$0(JLkotlin/jvm/functions/Function1;Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;JJ)V
    .locals 7
    .param p0, "$fileSize"    # J
    .param p2, "$onProgress"    # Lkotlin/jvm/functions/Function1;
    .param p3, "request"    # Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .param p4, "currentSize"    # J
    .param p6, "totalSize"    # J

    .line 82
    invoke-virtual {p3}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartNumber()I

    move-result v0

    add-int/lit8 v0, v0, -0x1

    int-to-long v0, v0

    mul-long/2addr v0, p6

    add-long/2addr v0, p4

    long-to-double v0, v0

    long-to-double v2, p0

    div-double/2addr v0, v2

    .line 83
    .local v0, "progress":D
    const/16 v2, 0x64

    int-to-double v3, v2

    mul-double/2addr v3, v0

    double-to-int v3, v3

    .line 84
    .local v3, "progressPercent":I
    invoke-static {v3}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v4

    invoke-interface {p2, v4}, Lkotlin/jvm/functions/Function1;->invoke(Ljava/lang/Object;)Ljava/lang/Object;

    .line 86
    rem-int/lit8 v4, v3, 0x19

    if-eqz v4, :cond_0

    if-ne v3, v2, :cond_1

    .line 87
    :cond_0
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v2

    new-instance v4, Ljava/lang/StringBuilder;

    invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v5, "\u4e0a\u4f20\u8fdb\u5ea6: "

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, v3}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, "% ("

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {p3}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartNumber()I

    move-result v5

    add-int/lit8 v5, v5, -0x1

    int-to-long v5, v5

    mul-long/2addr v5, p6

    add-long/2addr v5, p4

    invoke-virtual {v4, v5, v6}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const/16 v5, 0x2f

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4, p0, p1}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v4

    const-string v5, " bytes)"

    invoke-virtual {v4, v5}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v4

    invoke-virtual {v4}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v4

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 89
    :cond_1
    return-void
.end method


# virtual methods
.method public final create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;
    .locals 8
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Ljava/lang/Object;",
            "Lkotlin/coroutines/Continuation<",
            "*>;)",
            "Lkotlin/coroutines/Continuation<",
            "Lkotlin/Unit;",
            ">;"
        }
    .end annotation

    new-instance v7, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;

    iget-object v1, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    iget-boolean v2, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$isLog:Z

    iget-object v3, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    iget-object v4, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$onUpload:Lkotlin/jvm/functions/Function3;

    iget-object v5, p0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$onProgress:Lkotlin/jvm/functions/Function1;

    move-object v0, v7

    move-object v6, p2

    invoke-direct/range {v0 .. v6}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;-><init>(Ljava/lang/String;ZLcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;Lkotlin/jvm/functions/Function3;Lkotlin/jvm/functions/Function1;Lkotlin/coroutines/Continuation;)V

    check-cast v7, Lkotlin/coroutines/Continuation;

    return-object v7
.end method

.method public bridge synthetic invoke(Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;
    .locals 1

    check-cast p1, Lkotlinx/coroutines/CoroutineScope;

    check-cast p2, Lkotlin/coroutines/Continuation;

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invoke(Lkotlinx/coroutines/CoroutineScope;Lkotlin/coroutines/Continuation;)Ljava/lang/Object;
    .locals 2
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Lkotlinx/coroutines/CoroutineScope;",
            "Lkotlin/coroutines/Continuation<",
            "-",
            "Lkotlin/Unit;",
            ">;)",
            "Ljava/lang/Object;"
        }
    .end annotation

    invoke-virtual {p0, p1, p2}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->create(Ljava/lang/Object;Lkotlin/coroutines/Continuation;)Lkotlin/coroutines/Continuation;

    move-result-object v0

    check-cast v0, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;

    sget-object v1, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    invoke-virtual {v0, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;

    move-result-object v0

    return-object v0
.end method

.method public final invokeSuspend(Ljava/lang/Object;)Ljava/lang/Object;
    .locals 26

    const-string/jumbo v1, "\u5206\u7247["

    invoke-static {}, Lkotlin/coroutines/intrinsics/IntrinsicsKt;->getCOROUTINE_SUSPENDED()Ljava/lang/Object;

    .line 34
    move-object/from16 v2, p0

    iget v0, v2, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->label:I

    packed-switch v0, :pswitch_data_0

    new-instance v0, Ljava/lang/IllegalStateException;

    const-string v1, "call to \'resume\' before \'invoke\' with coroutine"

    invoke-direct {v0, v1}, Ljava/lang/IllegalStateException;-><init>(Ljava/lang/String;)V

    throw v0

    :pswitch_0
    invoke-static/range {p1 .. p1}, Lkotlin/ResultKt;->throwOnFailure(Ljava/lang/Object;)V

    move-object/from16 v3, p0

    .local v3, "this":Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;
    move-object/from16 v4, p1

    .line 35
    .local v4, "$result":Ljava/lang/Object;
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v5

    .line 36
    .local v5, "startTime":J
    new-instance v0, Ljava/io/File;

    iget-object v7, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    invoke-direct {v0, v7}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 37
    .local v0, "file":Ljava/io/File;
    invoke-virtual {v0}, Ljava/io/File;->length()J

    move-result-wide v7

    .line 39
    .end local v0    # "file":Ljava/io/File;
    .local v7, "fileSize":J
    iget-boolean v0, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$isLog:Z

    const-string/jumbo v9, "this as java.lang.String).substring(startIndex)"

    const/4 v10, 0x1

    if-eqz v0, :cond_0

    .line 40
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v11}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getPrefix()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    move-object v13, v12

    check-cast v13, Ljava/lang/CharSequence;

    const/16 v17, 0x6

    const/16 v18, 0x0

    const-string v14, "/"

    const/4 v15, 0x0

    const/16 v16, 0x0

    invoke-static/range {v13 .. v18}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v12

    add-int/2addr v12, v10

    invoke-virtual {v11, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    goto :goto_0

    .line 42
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v11}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getPrefix()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    invoke-static {v11}, Lcom/rokid/utils/MD5Util;->MD5(Ljava/lang/String;)Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    move-object v13, v12

    check-cast v13, Ljava/lang/CharSequence;

    const/16 v17, 0x6

    const/16 v18, 0x0

    const-string v14, "."

    const/4 v15, 0x0

    const/16 v16, 0x0

    invoke-static/range {v13 .. v18}, Lkotlin/text/StringsKt;->lastIndexOf$default(Ljava/lang/CharSequence;Ljava/lang/String;IZILjava/lang/Object;)I

    move-result v12

    invoke-virtual {v11, v12}, Ljava/lang/String;->substring(I)Ljava/lang/String;

    move-result-object v11

    invoke-static {v11, v9}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    invoke-virtual {v0, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    .line 39
    :goto_0
    nop

    .line 44
    .local v0, "objectKey":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v9

    new-instance v11, Ljava/lang/StringBuilder;

    invoke-direct {v11}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v12, "\u5f00\u59cbOSS\u4e0a\u4f20: file="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v7, v8}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v11

    const-string v12, " bytes, objectKey="

    invoke-virtual {v11, v12}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v11

    invoke-virtual {v11}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v11

    filled-new-array {v11}, [Ljava/lang/Object;

    move-result-object v11

    invoke-static {v9, v11}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 45
    new-instance v9, Lcom/alibaba/sdk/android/oss/ClientConfiguration;

    invoke-direct {v9}, Lcom/alibaba/sdk/android/oss/ClientConfiguration;-><init>()V

    .line 48
    .local v9, "configuration":Lcom/alibaba/sdk/android/oss/ClientConfiguration;
    new-instance v11, Lcom/alibaba/sdk/android/oss/common/auth/OSSStsTokenCredentialProvider;

    .line 49
    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getAccessKeyId()Ljava/lang/String;

    move-result-object v12

    .line 50
    iget-object v13, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getAccessKeySecret()Ljava/lang/String;

    move-result-object v13

    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v14}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getSecurityToken()Ljava/lang/String;

    move-result-object v14

    .line 48
    invoke-direct {v11, v12, v13, v14}, Lcom/alibaba/sdk/android/oss/common/auth/OSSStsTokenCredentialProvider;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;)V

    check-cast v11, Lcom/alibaba/sdk/android/oss/common/auth/OSSCredentialProvider;

    .line 47
    nop

    .line 52
    .local v11, "credentialProvider":Lcom/alibaba/sdk/android/oss/common/auth/OSSCredentialProvider;
    sget-object v12, Lcom/alibaba/sdk/android/oss/signer/SignVersion;->V4:Lcom/alibaba/sdk/android/oss/signer/SignVersion;

    invoke-virtual {v9, v12}, Lcom/alibaba/sdk/android/oss/ClientConfiguration;->setSignVersion(Lcom/alibaba/sdk/android/oss/signer/SignVersion;)V

    .line 54
    .end local v9    # "configuration":Lcom/alibaba/sdk/android/oss/ClientConfiguration;
    new-instance v9, Lcom/alibaba/sdk/android/oss/OSSClient;

    invoke-static {}, Lcom/blankj/utilcode/util/Utils;->getApp()Landroid/app/Application;

    move-result-object v12

    check-cast v12, Landroid/content/Context;

    iget-object v13, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v13}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getEndpoint()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v9, v12, v13, v11}, Lcom/alibaba/sdk/android/oss/OSSClient;-><init>(Landroid/content/Context;Ljava/lang/String;Lcom/alibaba/sdk/android/oss/common/auth/OSSCredentialProvider;)V

    .line 55
    .end local v11    # "credentialProvider":Lcom/alibaba/sdk/android/oss/common/auth/OSSCredentialProvider;
    .local v9, "oss":Lcom/alibaba/sdk/android/oss/OSSClient;
    iget-object v11, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v11}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getRegion()Ljava/lang/String;

    move-result-object v11

    invoke-virtual {v9, v11}, Lcom/alibaba/sdk/android/oss/OSSClient;->setRegion(Ljava/lang/String;)V

    .line 57
    new-instance v11, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;

    iget-object v12, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v12}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getBucket()Ljava/lang/String;

    move-result-object v12

    invoke-direct {v11, v12, v0}, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 58
    .local v11, "init":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;
    invoke-virtual {v9, v11}, Lcom/alibaba/sdk/android/oss/OSSClient;->initMultipartUpload(Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadRequest;)Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;

    move-result-object v11

    .line 59
    .local v11, "initResult":Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;
    invoke-virtual {v11}, Lcom/alibaba/sdk/android/oss/model/InitiateMultipartUploadResult;->getUploadId()Ljava/lang/String;

    move-result-object v11

    .line 63
    .local v11, "uploadId":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v12

    new-instance v13, Ljava/lang/StringBuilder;

    invoke-direct {v13}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v14, "uploadId: "

    invoke-virtual {v13, v14}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13, v11}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v13

    invoke-virtual {v13}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v13

    filled-new-array {v13}, [Ljava/lang/Object;

    move-result-object v13

    invoke-static {v12, v13}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 66
    nop

    .line 67
    const-wide/32 v12, 0xa00000

    cmp-long v12, v7, v12

    if-gez v12, :cond_1

    .line 68
    const-wide/32 v12, 0x19000

    .local v12, "partSize":J
    goto :goto_1

    .line 69
    .end local v12    # "partSize":J
    :cond_1
    const-wide/32 v12, 0x6400000

    cmp-long v12, v7, v12

    if-gez v12, :cond_2

    .line 70
    const-wide/32 v12, 0x500000

    .restart local v12    # "partSize":J
    goto :goto_1

    .line 71
    .end local v12    # "partSize":J
    :cond_2
    const-wide/32 v12, 0x40000000

    cmp-long v12, v7, v12

    if-gez v12, :cond_3

    .line 72
    const-wide/32 v12, 0xa00000

    .restart local v12    # "partSize":J
    goto :goto_1

    .line 74
    .end local v12    # "partSize":J
    :cond_3
    const-wide/32 v12, 0x1400000

    .line 76
    .restart local v12    # "partSize":J
    :goto_1
    long-to-double v14, v7

    move-object/from16 v16, v11

    .end local v11    # "uploadId":Ljava/lang/String;
    .local v16, "uploadId":Ljava/lang/String;
    long-to-double v10, v12

    div-double/2addr v14, v10

    invoke-static {v14, v15}, Ljava/lang/Math;->ceil(D)D

    move-result-wide v10

    double-to-int v10, v10

    .line 77
    .local v10, "count":I
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v11

    new-instance v14, Ljava/lang/StringBuilder;

    invoke-direct {v14}, Ljava/lang/StringBuilder;-><init>()V

    const-string/jumbo v15, "\u5206\u7247\u914d\u7f6e: count="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    invoke-virtual {v14, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v14

    const-string v15, ", partSize="

    invoke-virtual {v14, v15}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v14

    const/16 v15, 0x400

    move-object/from16 v17, v4

    move-wide/from16 v18, v5

    .end local v4    # "$result":Ljava/lang/Object;
    .end local v5    # "startTime":J
    .local v17, "$result":Ljava/lang/Object;
    .local v18, "startTime":J
    int-to-long v4, v15

    move-object v6, v1

    div-long v1, v12, v4

    invoke-virtual {v14, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "KB, totalSize="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    div-long v14, v7, v4

    div-long/2addr v14, v4

    invoke-virtual {v1, v14, v15}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "MB"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v11, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 78
    iget-object v1, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$onProgress:Lkotlin/jvm/functions/Function1;

    new-instance v2, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;

    invoke-direct {v2, v7, v8, v1}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$$ExternalSyntheticLambda0;-><init>(JLkotlin/jvm/functions/Function1;)V

    move-object v1, v2

    .line 91
    .local v1, "progressListener":Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    long-to-int v2, v12

    new-array v2, v2, [B

    .line 92
    .local v2, "data":[B
    new-instance v11, Ljava/io/RandomAccessFile;

    iget-object v14, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$filePath:Ljava/lang/String;

    const-string v15, "r"

    invoke-direct {v11, v14, v15}, Ljava/io/RandomAccessFile;-><init>(Ljava/lang/String;Ljava/lang/String;)V

    .line 93
    .local v11, "raf":Ljava/io/RandomAccessFile;
    new-instance v14, Ljava/util/ArrayList;

    invoke-direct {v14}, Ljava/util/ArrayList;-><init>()V

    check-cast v14, Ljava/util/List;

    .line 94
    .local v14, "partETags":Ljava/util/List;
    const/4 v15, 0x1

    .local v15, "i":I
    if-gt v15, v10, :cond_7

    .line 95
    :goto_2
    move-object/from16 v20, v2

    .end local v2    # "data":[B
    .local v20, "data":[B
    add-int/lit8 v2, v15, -0x1

    move-wide/from16 v21, v4

    int-to-long v4, v2

    mul-long/2addr v4, v12

    .line 96
    .local v4, "skip":J
    invoke-virtual {v11, v4, v5}, Ljava/io/RandomAccessFile;->seek(J)V

    .line 98
    .end local v4    # "skip":J
    if-ne v15, v10, :cond_4

    .line 99
    add-int/lit8 v2, v15, -0x1

    int-to-long v4, v2

    mul-long/2addr v4, v12

    sub-long v4, v7, v4

    .line 100
    .local v4, "remaining":J
    cmp-long v2, v4, v12

    if-gez v2, :cond_4

    .line 101
    .end local v12    # "partSize":J
    .end local v20    # "data":[B
    nop

    .line 102
    .local v4, "partSize":J
    long-to-int v2, v4

    new-array v2, v2, [B

    move-wide v12, v4

    .restart local v2    # "data":[B
    goto :goto_3

    .line 106
    .end local v2    # "data":[B
    .end local v4    # "partSize":J
    .restart local v12    # "partSize":J
    .restart local v20    # "data":[B
    :cond_4
    move-object/from16 v2, v20

    .end local v20    # "data":[B
    .restart local v2    # "data":[B
    :goto_3
    const/4 v4, 0x0

    long-to-int v5, v12

    invoke-virtual {v11, v2, v4, v5}, Ljava/io/RandomAccessFile;->readFully([BII)V

    .line 108
    new-instance v4, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;

    invoke-direct {v4}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;-><init>()V

    iget-object v5, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    move-object/from16 v20, v4

    .local v20, "$this$invokeSuspend_u24lambda_u241":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    const/16 v23, 0x0

    .line 109
    .local v23, "$i$a$-apply-OssUtil$ossUpload$2$uploadPart$1":I
    invoke-virtual {v5}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getBucket()Ljava/lang/String;

    move-result-object v5

    move-wide/from16 v24, v12

    move-object/from16 v12, v20

    .end local v20    # "$this$invokeSuspend_u24lambda_u241":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .local v12, "$this$invokeSuspend_u24lambda_u241":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .local v24, "partSize":J
    invoke-virtual {v12, v5}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setBucketName(Ljava/lang/String;)V

    .line 110
    invoke-virtual {v12, v0}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setObjectKey(Ljava/lang/String;)V

    .line 111
    move-object/from16 v5, v16

    .end local v16    # "uploadId":Ljava/lang/String;
    .local v5, "uploadId":Ljava/lang/String;
    invoke-virtual {v12, v5}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setUploadId(Ljava/lang/String;)V

    .line 112
    invoke-virtual {v12, v1}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setProgressCallback(Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;)V

    .line 113
    nop

    .line 108
    .end local v12    # "$this$invokeSuspend_u24lambda_u241":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .end local v23    # "$i$a$-apply-OssUtil$ossUpload$2$uploadPart$1":I
    nop

    .line 116
    .local v4, "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    invoke-virtual {v4, v15}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setPartNumber(I)V

    .line 117
    invoke-virtual {v4, v2}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->setPartContent([B)V

    .line 118
    nop

    .line 119
    :try_start_0
    invoke-virtual {v9, v4}, Lcom/alibaba/sdk/android/oss/OSSClient;->uploadPart(Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;)Lcom/alibaba/sdk/android/oss/model/UploadPartResult;

    move-result-object v12

    .line 121
    .local v12, "result":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    const/4 v13, 0x1

    if-eq v15, v13, :cond_6

    if-eq v15, v10, :cond_6

    rem-int/lit8 v16, v15, 0x5

    if-nez v16, :cond_5

    goto :goto_4

    :cond_5
    move-object/from16 v16, v1

    move-object/from16 v20, v2

    goto :goto_5

    .line 122
    :cond_6
    :goto_4
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v13

    move-object/from16 v16, v1

    .end local v1    # "progressListener":Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    .local v16, "progressListener":Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    new-instance v1, Ljava/lang/StringBuilder;

    invoke-direct {v1}, Ljava/lang/StringBuilder;-><init>()V

    move-object/from16 v20, v2

    .end local v2    # "data":[B
    .local v20, "data":[B
    const-string/jumbo v2, "\u5206\u7247\u4e0a\u4f20\u6210\u529f: ["

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const/16 v2, 0x2f

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1, v10}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "] eTag="

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v12}, Lcom/alibaba/sdk/android/oss/model/UploadPartResult;->getETag()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v13, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 124
    :goto_5
    new-instance v1, Lcom/alibaba/sdk/android/oss/model/PartETag;

    invoke-virtual {v4}, Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;->getPartNumber()I

    move-result v2

    invoke-virtual {v12}, Lcom/alibaba/sdk/android/oss/model/UploadPartResult;->getETag()Ljava/lang/String;

    move-result-object v13

    invoke-direct {v1, v2, v13}, Lcom/alibaba/sdk/android/oss/model/PartETag;-><init>(ILjava/lang/String;)V

    .line 125
    .end local v4    # "uploadPart":Lcom/alibaba/sdk/android/oss/model/UploadPartRequest;
    .local v1, "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    invoke-interface {v14, v1}, Ljava/util/List;->add(Ljava/lang/Object;)Z
    :try_end_0
    .catch Lcom/alibaba/sdk/android/oss/ServiceException; {:try_start_0 .. :try_end_0} :catch_1
    .catch Lcom/alibaba/sdk/android/oss/ClientException; {:try_start_0 .. :try_end_0} :catch_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 136
    nop

    .line 94
    .end local v1    # "partETag":Lcom/alibaba/sdk/android/oss/model/PartETag;
    .end local v12    # "result":Lcom/alibaba/sdk/android/oss/model/UploadPartResult;
    if-eq v15, v10, :cond_8

    add-int/lit8 v15, v15, 0x1

    move-object/from16 v1, v16

    move-object/from16 v2, v20

    move-wide/from16 v12, v24

    move-object/from16 v16, v5

    move-wide/from16 v4, v21

    goto/16 :goto_2

    .line 134
    .end local v0    # "objectKey":Ljava/lang/String;
    .end local v5    # "uploadId":Ljava/lang/String;
    .end local v7    # "fileSize":J
    .end local v9    # "oss":Lcom/alibaba/sdk/android/oss/OSSClient;
    .end local v10    # "count":I
    .end local v11    # "raf":Ljava/io/RandomAccessFile;
    .end local v14    # "partETags":Ljava/util/List;
    .end local v15    # "i":I
    .end local v16    # "progressListener":Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    .end local v18    # "startTime":J
    .end local v20    # "data":[B
    .end local v24    # "partSize":J
    :catchall_0
    move-exception v0

    goto :goto_6

    .line 130
    .restart local v15    # "i":I
    :catch_0
    move-exception v0

    .line 131
    .local v0, "clientException":Lcom/alibaba/sdk/android/oss/ClientException;
    :try_start_1
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "]\u4e0a\u4f20\u5931\u8d25: ClientException "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .end local v15    # "i":I
    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 132
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/ClientException;->getMessage()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;)V

    .line 133
    nop

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;
    .end local v17    # "$result":Ljava/lang/Object;
    throw v0

    .line 126
    .end local v0    # "clientException":Lcom/alibaba/sdk/android/oss/ClientException;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;
    .restart local v15    # "i":I
    .restart local v17    # "$result":Ljava/lang/Object;
    :catch_1
    move-exception v0

    .line 127
    .local v0, "serviceException":Lcom/alibaba/sdk/android/oss/ServiceException;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v1

    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V

    invoke-virtual {v2, v6}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v15}, Ljava/lang/StringBuilder;->append(I)Ljava/lang/StringBuilder;

    move-result-object v2

    const-string v4, "]\u4e0a\u4f20\u5931\u8d25: ServiceException "

    invoke-virtual {v2, v4}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v2

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2

    filled-new-array {v2}, [Ljava/lang/Object;

    move-result-object v2

    .end local v15    # "i":I
    invoke-static {v1, v2}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->e(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 128
    invoke-virtual {v0}, Lcom/alibaba/sdk/android/oss/ServiceException;->getErrorCode()Ljava/lang/String;

    move-result-object v1

    invoke-static {v1}, Lcom/alibaba/sdk/android/oss/common/OSSLog;->logError(Ljava/lang/String;)V

    .line 129
    nop

    .end local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;
    .end local v17    # "$result":Ljava/lang/Object;
    throw v0
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 134
    .end local v0    # "serviceException":Lcom/alibaba/sdk/android/oss/ServiceException;
    .restart local v3    # "this":Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;
    .restart local v17    # "$result":Ljava/lang/Object;
    :goto_6
    throw v0

    .line 94
    .local v0, "objectKey":Ljava/lang/String;
    .local v1, "progressListener":Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    .restart local v2    # "data":[B
    .restart local v7    # "fileSize":J
    .restart local v9    # "oss":Lcom/alibaba/sdk/android/oss/OSSClient;
    .restart local v10    # "count":I
    .restart local v11    # "raf":Ljava/io/RandomAccessFile;
    .local v12, "partSize":J
    .restart local v14    # "partETags":Ljava/util/List;
    .restart local v15    # "i":I
    .local v16, "uploadId":Ljava/lang/String;
    .restart local v18    # "startTime":J
    :cond_7
    move-wide/from16 v21, v4

    move-object/from16 v5, v16

    move-object/from16 v16, v1

    .line 138
    .end local v1    # "progressListener":Lcom/alibaba/sdk/android/oss/callback/OSSProgressCallback;
    .end local v2    # "data":[B
    .end local v10    # "count":I
    .end local v12    # "partSize":J
    .end local v15    # "i":I
    .end local v16    # "uploadId":Ljava/lang/String;
    .restart local v5    # "uploadId":Ljava/lang/String;
    :cond_8
    invoke-virtual {v11}, Ljava/io/RandomAccessFile;->close()V

    .line 139
    new-instance v1, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$1;

    invoke-direct {v1}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2$1;-><init>()V

    check-cast v1, Ljava/util/Comparator;

    invoke-static {v14, v1}, Ljava/util/Collections;->sort(Ljava/util/List;Ljava/util/Comparator;)V

    .line 150
    new-instance v1, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;

    .line 151
    iget-object v2, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$ossinfo:Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;

    invoke-virtual {v2}, Lcom/rokid/security/phone/sdk/server/filesystem/param/OssInitInfo;->getBucket()Ljava/lang/String;

    move-result-object v2

    .line 150
    invoke-direct {v1, v2, v0, v5, v14}, Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/util/List;)V

    .line 154
    .local v1, "complete":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;
    invoke-virtual {v9, v1}, Lcom/alibaba/sdk/android/oss/OSSClient;->completeMultipartUpload(Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;)Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadResult;

    .line 155
    invoke-static {}, Ljava/lang/System;->currentTimeMillis()J

    move-result-wide v12

    .line 156
    .local v12, "endTime":J
    move-object/from16 p1, v1

    .end local v1    # "complete":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;
    .local p1, "complete":Lcom/alibaba/sdk/android/oss/model/CompleteMultipartUploadRequest;
    sub-long v1, v12, v18

    .line 157
    .local v1, "duration":J
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v4

    new-instance v6, Ljava/lang/StringBuilder;

    invoke-direct {v6}, Ljava/lang/StringBuilder;-><init>()V

    const-string v10, "OSS\u4e0a\u4f20\u5b8c\u6210: objectKey="

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v10, ", \u8017\u65f6="

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    invoke-virtual {v6, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v6

    const-string v10, "ms, \u5e73\u5747\u901f\u5ea6="

    invoke-virtual {v6, v10}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v6

    div-long v15, v7, v1

    move-wide/from16 v23, v1

    .end local v1    # "duration":J
    .local v23, "duration":J
    div-long v1, v15, v21

    invoke-virtual {v6, v1, v2}, Ljava/lang/StringBuilder;->append(J)Ljava/lang/StringBuilder;

    move-result-object v1

    const-string v2, "KB/s"

    invoke-virtual {v1, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v1

    invoke-virtual {v1}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v1

    filled-new-array {v1}, [Ljava/lang/Object;

    move-result-object v1

    invoke-static {v4, v1}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->i(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 161
    const-string v1, ""

    .line 162
    .local v1, "md5":Ljava/lang/String;
    invoke-static {}, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil;->access$getTAG$p()Ljava/lang/String;

    move-result-object v2

    const-string v4, "MD5\u5c06\u7531\u4e0a\u5c42\u63d0\u4f9b\uff08\u9884\u8ba1\u7b97\u6a21\u5f0f\uff09"

    filled-new-array {v4}, [Ljava/lang/Object;

    move-result-object v4

    invoke-static {v2, v4}, Lcom/rokid/security/phone/sdk/base/utils/log/L;->d(Ljava/lang/String;[Ljava/lang/Object;)V

    .line 164
    iget-object v2, v3, Lcom/rokid/security/phone/sdk/server/filesystem/OssUtil$ossUpload$2;->$onUpload:Lkotlin/jvm/functions/Function3;

    invoke-static {v7, v8}, Lkotlin/coroutines/jvm/internal/Boxing;->boxLong(J)Ljava/lang/Long;

    move-result-object v4

    invoke-interface {v2, v4, v0, v1}, Lkotlin/jvm/functions/Function3;->invoke(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)Ljava/lang/Object;

    .line 165
    sget-object v2, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;

    return-object v2

    :pswitch_data_0
    .packed-switch 0x0
        :pswitch_0
    .end packed-switch
.end method
