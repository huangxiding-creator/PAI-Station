.class public Lio/minio/messages/RetentionDurationYears;
.super Ljava/lang/Object;
.source "RetentionDurationYears.java"

# interfaces
.implements Lio/minio/messages/RetentionDuration;


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "Years"
.end annotation


# instance fields
.field private years:Ljava/lang/Integer;
    .annotation runtime Lorg/simpleframework/xml/Text;
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 28
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method

.method public constructor <init>(I)V
    .locals 1
    .param p1, "years"    # I

    .line 30
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 31
    invoke-static {p1}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/RetentionDurationYears;->years:Ljava/lang/Integer;

    .line 32
    return-void
.end method


# virtual methods
.method public duration()I
    .locals 1

    .line 39
    iget-object v0, p0, Lio/minio/messages/RetentionDurationYears;->years:Ljava/lang/Integer;

    invoke-virtual {v0}, Ljava/lang/Integer;->intValue()I

    move-result v0

    return v0
.end method

.method public toString()Ljava/lang/String;
    .locals 3

    .line 45
    iget-object v0, p0, Lio/minio/messages/RetentionDurationYears;->years:Ljava/lang/Integer;

    if-nez v0, :cond_0

    .line 46
    const-string v0, ""

    return-object v0

    .line 48
    :cond_0
    new-instance v0, Ljava/lang/StringBuilder;

    invoke-direct {v0}, Ljava/lang/StringBuilder;-><init>()V

    iget-object v1, p0, Lio/minio/messages/RetentionDurationYears;->years:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->toString()Ljava/lang/String;

    move-result-object v1

    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    iget-object v1, p0, Lio/minio/messages/RetentionDurationYears;->years:Ljava/lang/Integer;

    invoke-virtual {v1}, Ljava/lang/Integer;->intValue()I

    move-result v1

    const/4 v2, 0x1

    if-ne v1, v2, :cond_1

    const-string v1, " year"

    goto :goto_0

    :cond_1
    const-string v1, " years"

    :goto_0
    invoke-virtual {v0, v1}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    move-result-object v0

    invoke-virtual {v0}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v0

    return-object v0
.end method

.method public unit()Lio/minio/messages/RetentionDurationUnit;
    .locals 1

    .line 35
    sget-object v0, Lio/minio/messages/RetentionDurationUnit;->YEARS:Lio/minio/messages/RetentionDurationUnit;

    return-object v0
.end method
