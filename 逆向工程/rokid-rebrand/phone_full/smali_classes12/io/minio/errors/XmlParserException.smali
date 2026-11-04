.class public Lio/minio/errors/XmlParserException;
.super Lio/minio/errors/MinioException;
.source "XmlParserException.java"


# static fields
.field private static final serialVersionUID:J = -0x35cfe434b85de675L


# direct methods
.method public constructor <init>(Ljava/lang/Exception;)V
    .locals 1
    .param p1, "e"    # Ljava/lang/Exception;

    .line 24
    invoke-virtual {p1}, Ljava/lang/Exception;->toString()Ljava/lang/String;

    move-result-object v0

    invoke-direct {p0, v0}, Lio/minio/errors/MinioException;-><init>(Ljava/lang/String;)V

    .line 25
    return-void
.end method
