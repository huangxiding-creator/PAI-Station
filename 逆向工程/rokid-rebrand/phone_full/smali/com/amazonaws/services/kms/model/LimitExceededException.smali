.class public Lcom/amazonaws/services/kms/model/LimitExceededException;
.super Lcom/amazonaws/AmazonServiceException;
.source "LimitExceededException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .line 37
    invoke-direct {p0, p1}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    .line 38
    return-void
.end method
