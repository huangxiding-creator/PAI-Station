.class public Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;
.super Ljava/lang/Object;
.source "BucketLifecycleRule.java"


# instance fields
.field private mArchiveDays:Ljava/lang/String;

.field private mArchiveExpireDate:Ljava/lang/String;

.field private mDays:Ljava/lang/String;

.field private mExpireDate:Ljava/lang/String;

.field private mIADays:Ljava/lang/String;

.field private mIAExpireDate:Ljava/lang/String;

.field private mIdentifier:Ljava/lang/String;

.field private mMultipartDays:Ljava/lang/String;

.field private mMultipartExpireDate:Ljava/lang/String;

.field private mPrefix:Ljava/lang/String;

.field private mStatus:Z


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getArchiveDays()Ljava/lang/String;
    .locals 1

    .line 89
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mArchiveDays:Ljava/lang/String;

    return-object v0
.end method

.method public getArchiveExpireDate()Ljava/lang/String;
    .locals 1

    .line 97
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mArchiveExpireDate:Ljava/lang/String;

    return-object v0
.end method

.method public getDays()Ljava/lang/String;
    .locals 1

    .line 41
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mDays:Ljava/lang/String;

    return-object v0
.end method

.method public getExpireDate()Ljava/lang/String;
    .locals 1

    .line 49
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mExpireDate:Ljava/lang/String;

    return-object v0
.end method

.method public getIADays()Ljava/lang/String;
    .locals 1

    .line 73
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mIADays:Ljava/lang/String;

    return-object v0
.end method

.method public getIAExpireDate()Ljava/lang/String;
    .locals 1

    .line 81
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mIAExpireDate:Ljava/lang/String;

    return-object v0
.end method

.method public getIdentifier()Ljava/lang/String;
    .locals 1

    .line 17
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mIdentifier:Ljava/lang/String;

    return-object v0
.end method

.method public getMultipartDays()Ljava/lang/String;
    .locals 1

    .line 57
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mMultipartDays:Ljava/lang/String;

    return-object v0
.end method

.method public getMultipartExpireDate()Ljava/lang/String;
    .locals 1

    .line 65
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mMultipartExpireDate:Ljava/lang/String;

    return-object v0
.end method

.method public getPrefix()Ljava/lang/String;
    .locals 1

    .line 25
    iget-object v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mPrefix:Ljava/lang/String;

    return-object v0
.end method

.method public getStatus()Z
    .locals 1

    .line 33
    iget-boolean v0, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mStatus:Z

    return v0
.end method

.method public setArchiveDays(Ljava/lang/String;)V
    .locals 0
    .param p1, "archiveDays"    # Ljava/lang/String;

    .line 93
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mArchiveDays:Ljava/lang/String;

    .line 94
    return-void
.end method

.method public setArchiveExpireDate(Ljava/lang/String;)V
    .locals 0
    .param p1, "archiveExpireDate"    # Ljava/lang/String;

    .line 101
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mArchiveExpireDate:Ljava/lang/String;

    .line 102
    return-void
.end method

.method public setDays(Ljava/lang/String;)V
    .locals 0
    .param p1, "days"    # Ljava/lang/String;

    .line 45
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mDays:Ljava/lang/String;

    .line 46
    return-void
.end method

.method public setExpireDate(Ljava/lang/String;)V
    .locals 0
    .param p1, "expireDate"    # Ljava/lang/String;

    .line 53
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mExpireDate:Ljava/lang/String;

    .line 54
    return-void
.end method

.method public setIADays(Ljava/lang/String;)V
    .locals 0
    .param p1, "iaDays"    # Ljava/lang/String;

    .line 77
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mIADays:Ljava/lang/String;

    .line 78
    return-void
.end method

.method public setIAExpireDate(Ljava/lang/String;)V
    .locals 0
    .param p1, "iaExpireDate"    # Ljava/lang/String;

    .line 85
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mIAExpireDate:Ljava/lang/String;

    .line 86
    return-void
.end method

.method public setIdentifier(Ljava/lang/String;)V
    .locals 0
    .param p1, "identifier"    # Ljava/lang/String;

    .line 21
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mIdentifier:Ljava/lang/String;

    .line 22
    return-void
.end method

.method public setMultipartDays(Ljava/lang/String;)V
    .locals 0
    .param p1, "multipartDays"    # Ljava/lang/String;

    .line 61
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mMultipartDays:Ljava/lang/String;

    .line 62
    return-void
.end method

.method public setMultipartExpireDate(Ljava/lang/String;)V
    .locals 0
    .param p1, "multipartExpireDate"    # Ljava/lang/String;

    .line 69
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mMultipartExpireDate:Ljava/lang/String;

    .line 70
    return-void
.end method

.method public setPrefix(Ljava/lang/String;)V
    .locals 0
    .param p1, "prefix"    # Ljava/lang/String;

    .line 29
    iput-object p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mPrefix:Ljava/lang/String;

    .line 30
    return-void
.end method

.method public setStatus(Z)V
    .locals 0
    .param p1, "status"    # Z

    .line 37
    iput-boolean p1, p0, Lcom/alibaba/sdk/android/oss/model/BucketLifecycleRule;->mStatus:Z

    .line 38
    return-void
.end method
