.class public Lio/minio/messages/Identity;
.super Ljava/lang/Object;
.source "Identity.java"


# instance fields
.field private principalId:Ljava/lang/String;
    .annotation runtime Lcom/fasterxml/jackson/annotation/JsonProperty;
    .end annotation
.end field


# direct methods
.method public constructor <init>()V
    .locals 0

    .line 26
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    return-void
.end method


# virtual methods
.method public principalId()Ljava/lang/String;
    .locals 1

    .line 30
    iget-object v0, p0, Lio/minio/messages/Identity;->principalId:Ljava/lang/String;

    return-object v0
.end method
