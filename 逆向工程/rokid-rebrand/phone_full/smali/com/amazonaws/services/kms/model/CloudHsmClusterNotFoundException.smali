.class public Lcom/amazonaws/services/kms/model/CloudHsmClusterNotFoundException;
.super Lcom/amazonaws/AmazonServiceException;
.source "CloudHsmClusterNotFoundException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .line 36
    invoke-direct {p0, p1}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    .line 37
    return-void
.end method
