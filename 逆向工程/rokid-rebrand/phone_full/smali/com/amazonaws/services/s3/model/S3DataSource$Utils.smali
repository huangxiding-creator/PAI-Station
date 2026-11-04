.class public final enum Lcom/amazonaws/services/s3/model/S3DataSource$Utils;
.super Ljava/lang/Enum;
.source "S3DataSource.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lcom/amazonaws/services/s3/model/S3DataSource;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x4019
    name = "Utils"
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Ljava/lang/Enum<",
        "Lcom/amazonaws/services/s3/model/S3DataSource$Utils;",
        ">;"
    }
.end annotation


# static fields
.field private static final synthetic $VALUES:[Lcom/amazonaws/services/s3/model/S3DataSource$Utils;


# direct methods
.method static constructor <clinit>()V
    .locals 1

    .line 37
    const/4 v0, 0x0

    new-array v0, v0, [Lcom/amazonaws/services/s3/model/S3DataSource$Utils;

    sput-object v0, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->$VALUES:[Lcom/amazonaws/services/s3/model/S3DataSource$Utils;

    return-void
.end method

.method private constructor <init>(Ljava/lang/String;I)V
    .locals 0
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .line 37
    invoke-direct {p0, p1, p2}, Ljava/lang/Enum;-><init>(Ljava/lang/String;I)V

    return-void
.end method

.method public static cleanupDataSource(Lcom/amazonaws/services/s3/model/S3DataSource;Ljava/io/File;Ljava/io/InputStream;Ljava/io/InputStream;Lcom/amazonaws/logging/Log;)V
    .locals 0
    .param p0, "req"    # Lcom/amazonaws/services/s3/model/S3DataSource;
    .param p1, "fileOrig"    # Ljava/io/File;
    .param p2, "inputStreamOrig"    # Ljava/io/InputStream;
    .param p3, "inputStreamCurr"    # Ljava/io/InputStream;
    .param p4, "log"    # Lcom/amazonaws/logging/Log;

    .line 46
    if-eqz p1, :cond_0

    .line 48
    invoke-static {p3, p4}, Lcom/amazonaws/util/IOUtils;->release(Ljava/io/Closeable;Lcom/amazonaws/logging/Log;)V

    .line 52
    :cond_0
    invoke-interface {p0, p2}, Lcom/amazonaws/services/s3/model/S3DataSource;->setInputStream(Ljava/io/InputStream;)V

    .line 53
    invoke-interface {p0, p1}, Lcom/amazonaws/services/s3/model/S3DataSource;->setFile(Ljava/io/File;)V

    .line 54
    return-void
.end method

.method public static valueOf(Ljava/lang/String;)Lcom/amazonaws/services/s3/model/S3DataSource$Utils;
    .locals 1
    .param p0, "name"    # Ljava/lang/String;

    .line 37
    const-class v0, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;

    invoke-static {v0, p0}, Ljava/lang/Enum;->valueOf(Ljava/lang/Class;Ljava/lang/String;)Ljava/lang/Enum;

    move-result-object v0

    check-cast v0, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;

    return-object v0
.end method

.method public static values()[Lcom/amazonaws/services/s3/model/S3DataSource$Utils;
    .locals 1

    .line 37
    sget-object v0, Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->$VALUES:[Lcom/amazonaws/services/s3/model/S3DataSource$Utils;

    invoke-virtual {v0}, [Lcom/amazonaws/services/s3/model/S3DataSource$Utils;->clone()Ljava/lang/Object;

    move-result-object v0

    check-cast v0, [Lcom/amazonaws/services/s3/model/S3DataSource$Utils;

    return-object v0
.end method
