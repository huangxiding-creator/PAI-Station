.class public Lcom/amazonaws/services/securitytoken/model/RegionDisabledException;
.super Lcom/amazonaws/AmazonServiceException;
.source "RegionDisabledException.java"


# static fields
.field private static final serialVersionUID:J = 0x1L


# direct methods
.method public constructor <init>(Ljava/lang/String;)V
    .locals 0
    .param p1, "message"    # Ljava/lang/String;

    .line 40
    invoke-direct {p0, p1}, Lcom/amazonaws/AmazonServiceException;-><init>(Ljava/lang/String;)V

    .line 41
    return-void
.end method
