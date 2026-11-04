.class public Lio/minio/messages/ReplicationTimeValue;
.super Ljava/lang/Object;
.source "ReplicationTimeValue.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ReplicationTimeValue"
.end annotation


# instance fields
.field private minutes:Ljava/lang/Integer;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Minutes"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Integer;)V
    .locals 1
    .param p1, "minutes"    # Ljava/lang/Integer;
        .annotation runtime Ljavax/annotation/Nullable;
        .end annotation

        .annotation runtime Lorg/simpleframework/xml/Element;
            name = "Minutes"
            required = false
        .end annotation
    .end param

    .line 31
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 27
    nop

    .line 28
    const/16 v0, 0xf

    invoke-static {v0}, Ljava/lang/Integer;->valueOf(I)Ljava/lang/Integer;

    move-result-object v0

    iput-object v0, p0, Lio/minio/messages/ReplicationTimeValue;->minutes:Ljava/lang/Integer;

    .line 32
    iput-object p1, p0, Lio/minio/messages/ReplicationTimeValue;->minutes:Ljava/lang/Integer;

    .line 33
    return-void
.end method


# virtual methods
.method public minutes()Ljava/lang/Integer;
    .locals 1

    .line 36
    iget-object v0, p0, Lio/minio/messages/ReplicationTimeValue;->minutes:Ljava/lang/Integer;

    return-object v0
.end method
