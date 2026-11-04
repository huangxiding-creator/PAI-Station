.class public Lcom/amazonaws/services/kms/model/CloudHsmClusterInUseException;
.super Lcom/amazonaws/AmazonServiceException;
.source "CloudHsmClusterInUseException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .line 44
    invoke-direct {p0, p1}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    .line 45
    return-void
.end method
