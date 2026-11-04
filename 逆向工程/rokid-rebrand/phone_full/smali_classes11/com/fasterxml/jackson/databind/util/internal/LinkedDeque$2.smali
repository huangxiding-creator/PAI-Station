.class Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;
.super Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;
.source "LinkedDeque.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingMethod;
    value = Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;->descendingIterator()Ljava/util/Iterator;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x0
    name = null
.end annotation

.annotation system Ldalvik/annotation/Signature;
    value = {
        "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque<",
        "TE;>.Abstract",
        "LinkedIterator;"
    }
.end annotation


# instance fields
.field final synthetic this$0:Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;


# direct methods
.method constructor <init>(Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;Lcom/fasterxml/jackson/databind/util/internal/Linked;)V
    .locals 0
    .param p1, "this$0"    # Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;

    .line 391
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;"
    .local p2, "start":Lcom/fasterxml/jackson/databind/util/internal/Linked;, "TE;"
    iput-object p1, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;->this$0:Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;

    invoke-direct {p0, p1, p2}, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$AbstractLinkedIterator;-><init>(Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque;Lcom/fasterxml/jackson/databind/util/internal/Linked;)V

    return-void
.end method


# virtual methods
.method computeNext()Lcom/fasterxml/jackson/databind/util/internal/Linked;
    .locals 1
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()TE;"
        }
    .end annotation

    .line 393
    .local p0, "this":Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;, "Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;"
    iget-object v0, p0, Lcom/fasterxml/jackson/databind/util/internal/LinkedDeque$2;->cursor:Lcom/fasterxml/jackson/databind/util/internal/Linked;

    invoke-interface {v0}, Lcom/fasterxml/jackson/databind/util/internal/Linked;->getPrevious()Lcom/fasterxml/jackson/databind/util/internal/Linked;

    move-result-object v0

    return-object v0
.end method
