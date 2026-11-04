.class public Lcom/amazonaws/services/securitytoken/model/PackedPolicyTooLargeException;
.super Lcom/amazonaws/AmazonServiceException;
.source "PackedPolicyTooLargeException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .line 48
    invoke-direct {p0, p1}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    .line 49
    return-void
.end method
