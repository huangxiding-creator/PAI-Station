.class public Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;
.super Lcom/alibaba/sdk/android/oss/model/OSSResult;
.source "GetBucketLoggingResult.java"


# instance fields
.field private mLoggingEnabled:Z

.field private mTargetBucketName:Ljava/lang/String;

.field private mTargetPrefix:Ljava/lang/String;


# direct methods
.method public constructor <init>()V
    .locals 1

    .line 3
    invoke-direct {p0}, Lcom/alibaba/sdk/android/oss/model/OSSResult;-><init>()V

    .line 6
    const/4 v0, 0x0

    iput-boolean v0, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mLoggingEnabled:Z

    return-void
.end method


# virtual methods
.method public getTargetBucketName()Ljava/lang/String;
    .locals 1

    .line 9
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mTargetBucketName:Ljava/lang/String;

    return-object v0
.end method

.method public getTargetPrefix()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mTargetPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public loggingEnabled()Z
    .locals 1

    .line 25
    iget-boolean v0, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mLoggingEnabled:Z

    return v0
.end method

.method public setLoggingEnabled(Z)V
    .locals 0
    .param p1, "loggingEnabled"    # Z

    .line 29
    iput-boolean p1, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mLoggingEnabled:Z

    .line 30
    return-void
.end method

.method public setTargetBucketName(Ljava/lang/String;)V
    .locals 0
    .param p1, "targetBucketName"    # Ljava/lang/String;

    .line 13
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mTargetBucketName:Ljava/lang/String;

    .line 14
    return-void
.end method

.method public setTargetPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "targetPrefix"    # Ljava/lang/String;

    .line 21
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/GetBucketLoggingResult;->mTargetPrefix:Ljava/lang/String;

    .line 22
    return-void
.end method
