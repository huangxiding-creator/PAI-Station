.class public final Lcom/rokid/logger/RKLogUploader;
.super Ljava/lang/Object;
.source "RKLogUploader.kt"


# annotations
.annotation system Ldalvik/annotation/SourceDebugExtension;
    value = "SMAP\nRKLogUploader.kt\nKotlin\n*S Kotlin\n*F\n+ 1 RKLogUploader.kt\ncom/rokid/logger/RKLogUploader\n+ 2 _Arrays.kt\nkotlin/collections/ArraysKt___ArraysKt\n*L\n1#1,64:1\n13536#2,2:65\n*S KotlinDebug\n*F\n+ 1 RKLogUploader.kt\ncom/rokid/logger/RKLogUploader\n*L\n44#1:65,2\n*E\n"
.end annotation

.annotation runtime Lkotlin/Metadata;
    d1 = {
        "\u0000(\n\u0002\u0018\u0002\n\u0002\u0010\u0000\n\u0002\u0008\u0002\n\u0002\u0010\u000e\n\u0002\u0008\u0004\n\u0002\u0018\u0002\n\u0002\u0008\t\n\u0002\u0018\u0002\n\u0000\n\u0002\u0010\u0002\n\u0000\u0008\u00c6\u0002\u0018\u00002\u00020\u0001B\u0007\u0008\u0002\u00a2\u0006\u0002\u0010\u0002J\u0010\u0010\u0011\u001a\u00020\u00042\u0006\u0010\u0012\u001a\u00020\u0013H\u0002J\u0006\u0010\u0014\u001a\u00020\u0015R\u000e\u0010\u0003\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0005\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0006\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u000e\u0010\u0007\u001a\u00020\u0004X\u0082T\u00a2\u0006\u0002\n\u0000R\u001b\u0010\u0008\u001a\u00020\t8BX\u0082\u0084\u0002\u00a2\u0006\u000c\n\u0004\u0008\u000c\u0010\r\u001a\u0004\u0008\n\u0010\u000bR\u0011\u0010\u000e\u001a\u00020\u0001\u00a2\u0006\u0008\n\u0000\u001a\u0004\u0008\u000f\u0010\u0010\u00a8\u0006\u0016"
    }
    d2 = {
        "Lcom/rokid/logger/RKLogUploader;",
        "",
        "()V",
        "ACCESS_KEY",
        "",
        "BUCKET_NAME",
        "ENDPOINT",
        "SECRET_KEY",
        "client",
        "Lcom/amazonaws/services/s3/AmazonS3Client;",
        "getClient",
        "()Lcom/amazonaws/services/s3/AmazonS3Client;",
        "client$delegate",
        "Lkotlin/Lazy;",
        "uploadLock",
        "getUploadLock",
        "()Ljava/lang/Object;",
        "getDateStr",
        "date",
        "Ljava/util/Date;",
        "upload",
        "",
        "logger_release"
    }
    k = 0x1
    mv = {
        0x1,
        0x5,
        0x1
    }
    xi = 0x30
.end annotation


# static fields
.field private static final ACCESS_KEY:Ljava/lang/String; = "LINUJFMH70X6WOT4R6A0"

.field private static final BUCKET_NAME:Ljava/lang/String; = "sdk-log"

.field private static final ENDPOINT:Ljava/lang/String; = "https://file-openar.rokid.com:443"

.field public static final INSTANCE:Lcom/rokid/logger/RKLogUploader;

.field private static final SECRET_KEY:Ljava/lang/String; = "ucoc+ISx95OjPmpdS0mJII1bp0OcwuJzj2ln79dt"

.field private static final client$delegate:Lkotlin/Lazy;

.field private static final uploadLock:Ljava/lang/Object;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    new-instance v0, Lcom/rokid/logger/RKLogUploader;

    invoke-direct {v0}, Lcom/rokid/logger/RKLogUploader;-><init>()V

    sput-object v0, Lcom/rokid/logger/RKLogUploader;->INSTANCE:Lcom/rokid/logger/RKLogUploader;

    .line 21
    new-instance v0, Ljava/lang/Object;

    invoke-direct {v0}, Ljava/lang/Object;-><init>()V

    sput-object v0, Lcom/rokid/logger/RKLogUploader;->uploadLock:Ljava/lang/Object;

    .line 23
    sget-object v0, Lcom/rokid/logger/RKLogUploader$client$2;->INSTANCE:Lcom/rokid/logger/RKLogUploader$client$2;

    check-cast v0, Lkotlin/jvm/functions/Function0;

    invoke-static {v0}, Lkotlin/LazyKt;->lazy(Lkotlin/jvm/functions/Function0;)Lkotlin/Lazy;

    move-result-object v0

    sput-object v0, Lcom/rokid/logger/RKLogUploader;->client$delegate:Lkotlin/Lazy;

    return-void
.end method

.method private constructor <init>()V
    .locals 0

    .line 14
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method private final getClient()Lcom/amazonaws/services/s3/AmazonS3Client;
    .locals 1

    .line 23
    sget-object v0, Lcom/rokid/logger/RKLogUploader;->client$delegate:Lkotlin/Lazy;

    invoke-interface {v0}, Lkotlin/Lazy;->getValue()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/s3/AmazonS3Client;

    return-object v0
.end method

.method private final getDateStr(Ljava/util/Date;)Ljava/lang/String;
    .locals 3
    .param p1, "date"    # Ljava/util/Date;

    .line 61
    new-instance v0, Ljava/text/SimpleDateFormat;

    const-string v1, "yyyy-MM-dd HH:mm:ss"

    invoke-static {}, Ljava/util/Locale;->getDefault()Ljava/util/Locale;

    move-result-object v2

    invoke-direct {v0, v1, v2}, Ljava/text/SimpleDateFormat;-><init>(Ljava/lang/String;Ljava/util/Locale;)V

    .line 62
    .local v0, "sdf":Ljava/text/SimpleDateFormat;
    invoke-virtual {v0, p1}, Ljava/text/SimpleDateFormat;->format(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v1

    const-string v2, "sdf.format(date)"

    invoke-static {v1, v2}, Lkotlin/jvm/internal/Intrinsics;->checkNotNullExpressionValue(Ljava/lang/Object;Ljava/lang/String;)V

    return-object v1
.end method


# virtual methods
.method public final getUploadLock()Ljava/lang/Object;
    .locals 1

    .line 21
    sget-object v0, Lcom/rokid/logger/RKLogUploader;->uploadLock:Ljava/lang/Object;

    return-object v0
.end method

.method public final upload()V
    .locals 18

    .line 40
    sget-object v1, Lcom/rokid/logger/RKLogUploader;->uploadLock:Ljava/lang/Object;

    monitor-enter v1

    const/4 v0, 0x0

    .line 41
    .local v0, "$i$a$-synchronized-RKLogUploader$upload$1":I
    :try_start_0
    sget-object v2, Lcom/rokid/logger/RKLogger2;->Companion:Lcom/rokid/logger/RKLogger2$Companion;

    invoke-virtual {v2}, Lcom/rokid/logger/RKLogger2$Companion;->getLogPath()Ljava/lang/String;

    move-result-object v2

    if-nez v2, :cond_0

    move/from16 v16, v0

    goto/16 :goto_3

    .local v2, "path":Ljava/lang/String;
    :cond_0
    const/4 v3, 0x0

    .line 42
    .local v3, "$i$a$-let-RKLogUploader$upload$1$1":I
    new-instance v4, Ljava/io/File;

    invoke-direct {v4, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .line 43
    .local v4, "directory":Ljava/io/File;
    invoke-virtual {v4}, Ljava/io/File;->exists()Z

    move-result v5

    if-eqz v5, :cond_4

    invoke-virtual {v4}, Ljava/io/File;->isDirectory()Z

    move-result v5

    if-eqz v5, :cond_4

    .line 44
    invoke-virtual {v4}, Ljava/io/File;->listFiles()[Ljava/io/File;

    move-result-object v5

    if-nez v5, :cond_1

    move/from16 v16, v0

    move-object/from16 v17, v2

    goto/16 :goto_2

    .local v5, "$this$forEach$iv":[Ljava/lang/Object;
    :cond_1
    const/4 v6, 0x0

    .line 65
    .local v6, "$i$f$forEach":I
    array-length v7, v5

    const/4 v8, 0x0

    :goto_0
    if-ge v8, v7, :cond_3

    aget-object v9, v5, v8

    .local v9, "element$iv":Ljava/lang/Object;
    move-object v10, v9

    .local v10, "file":Ljava/io/File;
    const/4 v11, 0x0

    .line 45
    .local v11, "$i$a$-forEach-RKLogUploader$upload$1$1$1":I
    invoke-virtual {v10}, Ljava/io/File;->isFile()Z

    move-result v12

    if-eqz v12, :cond_2

    .line 46
    sget-object v12, Lcom/rokid/logger/RKLogUploader;->INSTANCE:Lcom/rokid/logger/RKLogUploader;

    invoke-direct {v12}, Lcom/rokid/logger/RKLogUploader;->getClient()Lcom/amazonaws/services/s3/AmazonS3Client;

    move-result-object v12

    .line 47
    new-instance v13, Lcom/amazonaws/services/s3/model/PutObjectRequest;

    const-string v14, "sdk-log"

    new-instance v15, Ljava/lang/StringBuilder;

    invoke-direct {v15}, Ljava/lang/StringBuilder;-><init>()V

    move/from16 v16, v0

    .end local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .local v16, "$i$a$-synchronized-RKLogUploader$upload$1":I
    const-string v0, "Android/"

    invoke-virtual {v15, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    sget-object v15, Lcom/rokid/logger/RKLogUploader;->INSTANCE:Lcom/rokid/logger/RKLogUploader;

    move-object/from16 v17, v2

    .end local v2    # "path":Ljava/lang/String;
    .local v17, "path":Ljava/lang/String;
    new-instance v2, Ljava/util/Date;

    invoke-direct {v2}, Ljava/util/Date;-><init>()V

    invoke-direct {v15, v2}, Lcom/rokid/logger/RKLogUploader;->getDateStr(Ljava/util/Date;)Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    const/16 v2, 0x2d

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(C)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v10}, Ljava/io/File;->getName()Ljava/lang/String;

    move-result-object v2

    invoke-virtual {v0, v2}, Ljava/lang/StringBuilder;->append(Ljava/lang/Object;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {v13, v14, v0, v10}, Lcom/amazonaws/services/s3/model/PutObjectRequest;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/io/File;)V

    .line 48
    new-instance v0, Lcom/amazonaws/services/s3/model/ObjectMetadata;

    invoke-direct {v0}, Lcom/amazonaws/services/s3/model/ObjectMetadata;-><init>()V

    invoke-virtual {v13, v0}, Lcom/amazonaws/services/s3/model/PutObjectRequest;->withMetadata(Lcom/amazonaws/services/s3/model/ObjectMetadata;)Lcom/amazonaws/services/s3/model/PutObjectRequest;

    move-result-object v0

    .line 46
    invoke-virtual {v12, v0}, Lcom/amazonaws/services/s3/AmazonS3Client;->putObject(Lcom/amazonaws/services/s3/model/PutObjectRequest;)Lcom/amazonaws/services/s3/model/PutObjectResult;

    .line 49
    invoke-virtual {v10}, Ljava/io/File;->delete()Z

    goto :goto_1

    .line 45
    .end local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .end local v17    # "path":Ljava/lang/String;
    .restart local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .restart local v2    # "path":Ljava/lang/String;
    :cond_2
    move/from16 v16, v0

    move-object/from16 v17, v2

    .line 51
    .end local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .end local v2    # "path":Ljava/lang/String;
    .restart local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .restart local v17    # "path":Ljava/lang/String;
    :goto_1
    nop

    .end local v9    # "element$iv":Ljava/lang/Object;
    .end local v10    # "file":Ljava/io/File;
    .end local v11    # "$i$a$-forEach-RKLogUploader$upload$1$1$1":I
    add-int/lit8 v8, v8, 0x1

    move/from16 v0, v16

    move-object/from16 v2, v17

    goto :goto_0

    .line 66
    .end local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .end local v17    # "path":Ljava/lang/String;
    .restart local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .restart local v2    # "path":Ljava/lang/String;
    :cond_3
    move/from16 v16, v0

    move-object/from16 v17, v2

    .end local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .end local v2    # "path":Ljava/lang/String;
    .restart local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .restart local v17    # "path":Ljava/lang/String;
    goto :goto_2

    .line 43
    .end local v5    # "$this$forEach$iv":[Ljava/lang/Object;
    .end local v6    # "$i$f$forEach":I
    .end local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .end local v17    # "path":Ljava/lang/String;
    .restart local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .restart local v2    # "path":Ljava/lang/String;
    :cond_4
    move/from16 v16, v0

    move-object/from16 v17, v2

    .line 54
    .end local v0    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .end local v2    # "path":Ljava/lang/String;
    .restart local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    .restart local v17    # "path":Ljava/lang/String;
    :goto_2
    nop

    .line 41
    .end local v3    # "$i$a$-let-RKLogUploader$upload$1$1":I
    .end local v4    # "directory":Ljava/io/File;
    .end local v17    # "path":Ljava/lang/String;
    sget-object v0, Lkotlin/Unit;->INSTANCE:Lkotlin/Unit;
    :try_end_0
    .catchall {:try_start_0 .. :try_end_0} :catchall_0

    .line 40
    .end local v16    # "$i$a$-synchronized-RKLogUploader$upload$1":I
    :goto_3
    monitor-exit v1

    .line 58
    return-void

    .line 40
    :catchall_0
    move-exception v0

    monitor-exit v1

    throw v0
.end method
