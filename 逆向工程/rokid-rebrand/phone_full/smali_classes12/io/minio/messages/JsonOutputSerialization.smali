.class public Lio/minio/messages/JsonOutputSerialization;
.super Ljava/lang/Object;
.source "JsonOutputSerialization.java"


# annotations
.annotation runtime Lorg/simpleframework/xml/Root;
    name = "JSON"
.end annotation


# instance fields
.field private recordDelimiter:Ljava/lang/Character;
    .annotation runtime Lorg/simpleframework/xml/Element;
        name = "RecordDelimiter"
        required = false
    .end annotation
.end field


# direct methods
.method public constructor <init>(Ljava/lang/Character;)V
    .locals 0
    .param p1, "recordDelimiter"    # Ljava/lang/Character;

    .line 33
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    .line 34
    iput-object p1, p0, Lio/minio/messages/JsonOutputSerialization;->recordDelimiter:Ljava/lang/Character;

    .line 35
    return-void
.end method
