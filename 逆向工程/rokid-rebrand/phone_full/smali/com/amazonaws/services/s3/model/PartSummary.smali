.class public Lcom/amazonaws/services/s3/model/PartSummary;
.super Ljava/lang/Object;
.source "PartSummary.java"


# instance fields
.field private eTag:Ljava/lang/String;

.field private lastModified:Ljava/util/Date;

.field private partNumber:I

.field private size:J


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 24
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public getETag()Ljava/lang/String;
    .locals 1

    .line 92
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/PartSummary;->eTag:Ljava/lang/String;

    return-object v0
.end method

.method public getLastModified()Ljava/util/Date;
    .locals 1

    .line 74
    iget-object v0, p0, Lcom/amazonaws/services/s3/model/PartSummary;->lastModified:Ljava/util/Date;

    return-object v0
.end method

.method public getPartNumber()I
    .locals 1

    .line 52
    iget v0, p0, Lcom/amazonaws/services/s3/model/PartSummary;->partNumber:I

    return v0
.end method

.method public getSize()J
    .locals 2

    .line 110
    iget-wide v0, p0, Lcom/amazonaws/services/s3/model/PartSummary;->size:J

    return-wide v0
.end method

.method public setETag(Ljava/lang/String;)V
    .locals 0
    .param p1, "eTag"    # Ljava/lang/String;

    .line 101
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/PartSummary;->eTag:Ljava/lang/String;

    .line 102
    return-void
.end method

.method public setLastModified(Ljava/util/Date;)V
    .locals 0
    .param p1, "lastModified"    # Ljava/util/Date;

    .line 83
    iput-object p1, p0, Lcom/amazonaws/services/s3/model/PartSummary;->lastModified:Ljava/util/Date;

    .line 84
    return-void
.end method

.method public setPartNumber(I)V
    .locals 0
    .param p1, "partNumber"    # I

    .line 65
    iput p1, p0, Lcom/amazonaws/services/s3/model/PartSummary;->partNumber:I

    .line 66
    return-void
.end method

.method public setSize(J)V
    .locals 0
    .param p1, "size"    # J

    .line 119
    iput-wide p1, p0, Lcom/amazonaws/services/s3/model/PartSummary;->size:J

    .line 120
    return-void
.end method
