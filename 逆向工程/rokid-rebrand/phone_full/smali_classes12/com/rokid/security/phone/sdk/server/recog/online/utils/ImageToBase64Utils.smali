.class public final Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;
.super Ljava/lang/Object;
.source "ImageToBase64Utils.kt"


# annotations
.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000\u001a\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0000\n\u0002\u0010\u0012\n\u0002\u0008\u0003\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0003\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0005\u001a\u00020\u0006J\u0010\u0010\u0007\u001a\u0004\u0018\u00010\u00042\u0006\u0010\u0008\u001a\u00020\u0004\u00a8\u0006\t"
    }
    d2 = {
        "Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;",
        "",
        "()V",
        "dataToBase64",
        "",
        "bytes",
        "",
        "fileToBase64",
        "filePath",
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
.field public static final INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;

    invoke-direct {v0}, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;-><init>()V

    sput-object v0, Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;->INSTANCE:Lcom/rokid/security/phone/sdk/server/recog/online/utils/ImageToBase64Utils;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public final dataToBase64([B)Ljava/lang/String;
    .locals 1
    .param p1, "bytes"    # [B

    const-string v0, "bytes"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 41
    nop

    .line 42
    const/4 v0, 0x2

    :try_start_0
    invoke-static {p1, v0}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    .line 43
    .local v0, "base64":Ljava/lang/String;
    return-object v0

    .line 44
    .end local v0    # "base64":Ljava/lang/String;
    :catch_0
    move-exception v0

    .line 45
    .local v0, "e":Ljava/lang/Exception;
    invoke-virtual {v0}, Ljava/lang/Exception;->printStackTrace()V

    .line 47
    .end local v0    # "e":Ljava/lang/Exception;
    const/4 v0, 0x0

    return-object v0
.end method

.method public final fileToBase64(Ljava/lang/String;)Ljava/lang/String;
    .locals 8
    .param p1, "filePath"    # Ljava/lang/String;

    const-string v0, "filePath"

    invoke-static {p1, v0}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullParameter(Ljava/lang/Object;Ljava/lang/String;)V

    .line 22
    nop

    .line 23
    const/4 v0, 0x0

    :try_start_0
    new-instance v1, Ljava/io/File;

    invoke-direct {v1, p1}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 24
    .local v1, "file":Ljava/io/File;
    invoke-virtual {v1}, Ljava/io/File;->exists()Z

    move-result v2

    if-eqz v2, :cond_1

    invoke-virtual {v1}, Ljava/io/File;->isFile()Z

    move-result v2

    if-nez v2, :cond_0

    goto :goto_0

    .line 27
    :cond_0
    new-instance v2, Ljava/io/FileInputStream;

    invoke-direct {v2, v1}, Ljava/io/FileInputStream;-><init>(Ljava/io/File;)V

    check-cast v2, Ljava/io/Closeable;
    :try_end_0
    .catch Ljava/lang/Exception; {:try_start_0 .. :try_end_0} :catch_0

    :try_start_1
    move-object v3, v2

    check-cast v3, Ljava/io/FileInputStream;

    .local v3, "fis":Ljava/io/FileInputStream;
    const/4 v4, 0x0

    .line 28
    .local v4, "$i$a$-use-ImageToBase64Utils$fileToBase64$bytes$1":I
    invoke-virtual {v1}, Ljava/io/File;->length()J

    move-result-wide v5

    long-to-int v5, v5

    new-array v5, v5, [B

    move-object v6, v5

    .local v6, "$this$fileToBase64_u24lambda_u241_u24lambda_u240":[B
    const/4 v7, 0x0

    .line 29
    .local v7, "$i$a$-apply-ImageToBase64Utils$fileToBase64$bytes$1$1":I
    invoke-virtual {v3, v6}, Ljava/io/FileInputStream;->read([B)I
    :try_end_1
    .catchall {:try_start_1 .. :try_end_1} :catchall_0

    .line 30
    nop

    .line 28
    .end local v6    # "$this$fileToBase64_u24lambda_u241_u24lambda_u240":[B
    .end local v7    # "$i$a$-apply-ImageToBase64Utils$fileToBase64$bytes$1$1":I
    nop

    .line 27
    .end local v3    # "fis":Ljava/io/FileInputStream;
    .end local v4    # "$i$a$-use-ImageToBase64Utils$fileToBase64$bytes$1":I
    :try_start_2
    invoke-static {v2, v0}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    move-object v2, v5

    .line 32
    .local v2, "bytes":[B
    const/4 v3, 0x2

    invoke-static {v2, v3}, Landroid/util/Base64;->encodeToString([BI)Ljava/lang/String;

    move-result-object v0
    :try_end_2
    .catch Ljava/lang/Exception; {:try_start_2 .. :try_end_2} :catch_0

    .line 33
    .local v0, "base64":Ljava/lang/String;
    return-object v0

    .line 27
    .end local v0    # "base64":Ljava/lang/String;
    .end local v2    # "bytes":[B
    :catchall_0
    move-exception v3

    .end local v1    # "file":Ljava/io/File;
    .end local p1    # "filePath":Ljava/lang/String;
    :try_start_3
    throw v3
    :try_end_3
    .catchall {:try_start_3 .. :try_end_3} :catchall_1

    .restart local v1    # "file":Ljava/io/File;
    .restart local p1    # "filePath":Ljava/lang/String;
    :catchall_1
    move-exception v4

    :try_start_4
    invoke-static {v2, v3}, Lkotlin/io/CloseableKt;->closeFinally(Ljava/io/Closeable;Ljava/lang/Throwable;)V

    .end local p1    # "filePath":Ljava/lang/String;
    throw v4
    :try_end_4
    .catch Ljava/lang/Exception; {:try_start_4 .. :try_end_4} :catch_0

    .line 25
    .restart local p1    # "filePath":Ljava/lang/String;
    :cond_1
    :goto_0
    return-object v0

    .line 34
    .end local v1    # "file":Ljava/io/File;
    :catch_0
    move-exception v1

    .line 35
    .local v1, "e":Ljava/lang/Exception;
    invoke-virtual {v1}, Ljava/lang/Exception;->printStackTrace()V

    .line 37
    .end local v1    # "e":Ljava/lang/Exception;
    return-object v0
.end method
