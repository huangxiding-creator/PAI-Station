.class public Lio/minio/messages/ScanRange;
.super Ljava/lang/Object;
.source "ScanRange.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "ScanRange"
.end annotation


# instance fields
.field private end:Ljava/lang/Long;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "End"
        required = false
    .end annotation
.end field

.field private start:Ljava/lang/Long;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "Start"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Long;Ljava/lang/Long;)V
    .locals 0
    .param p1, "start"    # Ljava/lang/Long;
    .param p2, "end"    # Ljava/lang/Long;

    .line 36
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 37
    iput-object p1, p0, Lio/minio/messages/ScanRange;->start:Ljava/lang/Long;

    .line 38
    iput-object p2, p0, Lio/minio/messages/ScanRange;->end:Ljava/lang/Long;

    .line 39
    return-void
.end method
